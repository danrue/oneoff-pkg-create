oneoff-pkg-create
=================

Create a FreeBSD pkgng-style package from an arbitrary directory of files.

Based on [bdrewery/freebsd_base_pkgng]
(https://github.com/bdrewery/freebsd_base_pkgng)

Usage
=====

Provide a manifest_template with the name and particulars of your package, 
along with a directory path. All files in the directory path provided will
be recursively added to the package.

    Usage: build-pkg.sh <manifest_template> <files_directory>

Example
=======

Create an example package that will install a file named /usr/local/test/README

    ./build-pkg.sh manifest_template.example example

The example package can be added with

    pkg add my-fortune-20140624.txz

