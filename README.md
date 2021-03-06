FastMath
========

[![Build Status](https://travis-ci.org/stephenjust/fastmath.png?branch=master)](https://travis-ci.org/stephenjust/fastmath)

Web-app for some speed calculus

How to Play
-----------

The concept of FastMath is simple: the system will generate a math problem for you, and you type in the answer as fast as you can. The problem types are designed such that after completing some beginner calculus courses, you should be able to solve these problems mentally with very little trouble.


Preparing Your System
---------------------

In order to prepare your system to run FastMath, you must install some prerequisites.

On Windows:
* Install Python 3.3+ (64-bit binary works fine). Ensure you add python.exe to your PATH when the installer asks.
* Install sympy
   * Get SymPy from GitHub: `git clone http://github.com/sympy/sympy.git`
   * Open a command prompt as an administrator
   * Navigate to your sympy folder
   * Run `python setup.py install`
* Install Cython from http://www.lfd.uci.edu/~gohlke/pythonlibs/#cython
* Install lxml from http://www.lfd.uci.edu/~gohlke/pythonlibs/#lxml
* Install Django 1.6.x
   * Download a tarball from https://www.djangoproject.com/download/ and extract it with 7-zip, WinRAR or some other tool.
   * Open a command prompt as an administrator
   * Navigate to the django folder
   * Run `python setup.py install`
   * Add 'C:\Python33\Lib\site-packages\django\bin' to your path


