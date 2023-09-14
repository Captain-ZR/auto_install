#!/bin/bash

password=$1
files_dir="./auto_install"
tar_file_name="auto_install.tar.gz"

clear_all() {
    rm -rf ${tar_file_name}
    rm -rf $0
}

get_files() {
    version=$(wget --no-check-certificate -qO- https://api.github.com/repos/Captain-ZR/auto_install/releases/latest | grep 'tag_name' | cut -d\" -f4)
    download_link="https://github.com/Captain-ZR/auto_install/releases/download/${version}/${tar_file_name}"
    wget ${download_link}

   # rm -rf $0	# delete self
}

decompress() {
    #tar -zcvf - auto_install/ | openssl aes-256-ecb -pbkdf2 -k $password -out auto_install.tar.gz	#加密压缩
    openssl aes-256-ecb -d -k $password -pbkdf2 -in ./${tar_file_name} | tar -zxvf -			#解密压缩
}

execute() {
    clear_all
    mv ${files_dir}/auto_install.sh ./
    ./auto_install.sh
}

get_files
decompress
execute

