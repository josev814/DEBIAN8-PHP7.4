#!/usr/bin/env bash
php_version=7.4
#files_to_md5=("usr/share/bug/php${php_version}/control"  "usr/share/doc/php${php_version}/NEWS.Debian.gz" "usr/share/doc/php${php_version}/changelog.Debian.gz" "usr/share/doc/php${php_version}/changelog.gz" "usr/share/doc/php${php_version}/copyright" )

#rm $md5_file
#for file in "${files_to_md5[@]}"
#do
#  md5sum "${file}" >> "${md5_file}"
#done

#tar -cvf ../build/data.tar.xz ./*
#cd ../control
#tar -czvf ../build/control.tar.gz ./*
#cd ../

for package_dir in $(ls -d */);
do
  if [ "${package_dir}" != 'builds/' ]
  then
    echo "Packing up ${package_dir}"
    chmod 0775 -R ${package_dir}
    # the addition of --root-owner-group was added in dpkg-dev 1.19
    # Deb 8 package is 1.17
    #dpkg-deb --build --root-owner-group ${package_dir}
    if [[ "${package_dir}" == 'libapache2-mod-php7.2' ]]
    then
      cd "${package_dir}"
      ln -s php${php_version}-common usr/share/doc/libapache2-mod-php${php_version}
      cd ../
    fi
    dpkg-deb --build ${package_dir}
    mv "${package_dir//\//}.deb" builds/
  fi
done
