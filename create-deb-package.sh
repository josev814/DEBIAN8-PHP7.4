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

cd builds || exit
pwd
for package_dir in $(ls -d ../*/);
do
  if [ "${package_dir}" != '../builds/' ]
  then
    echo "Packing up ${package_dir}"
    chmod 0755 -R ${package_dir}/DEBIAN
    dpkg-deb --build --root-owner-group ${package_dir}
  fi
done
