#! /usr/bin/env python3

import os

os.chdir(os.path.expanduser("~/Desktop"))

dot_desktop_files = [file for file in os.listdir(os.curdir) if file.endswith(".desktop")]
dot_desktop_dict = {}
for dot_desktop_file in dot_desktop_files:
    dot_desktop_dict.update({dot_desktop_file: open(dot_desktop_file).readlines()})

def file_key_value(filename, keyname):
    for line in dot_desktop_dict[filename]:
        key, value = line.split("=")[0], ("=".join(line.split("=")[1:]).rstrip())
        if key == keyname:
            return value
        

for filename in dot_desktop_files:
    if file_key_value(filename, "Type") == "Link":
        link_to_name = file_key_value(filename, "URL")
        open(filename, "w").write(open(link_to_name).read())

