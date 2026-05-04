## 54. Exercise: Website File Management
# 📝 Exercise: Website File Management

## Steps

1. **Navigate** to your Desktop, making it your new current working directory.
    - If you’re using **Windows Subsystem for Linux**, feel free to navigate to your actual desktop.

2. **Create** a new directory called `tmp_website`.

3. Inside the `tmp_website` directory, create 3 (empty) files:
    - `index.html`
    - `style.css`
    - `script.js`

4. **Create** a new subdirectory `styles` and **move** the file `style.css` into this new directory.

5. **Create** a new sub-directory `scripts`.

6. **Rename** the file `script.js` to `index.js` and **move** it into the `scripts` sub-directory (in one command).

7. **Create** a new (empty) file `page1.html` inside a new sub-directory called `pages`.
    - (You will have to create this folder first before creating the file.)

8. **Copy** the file `page1.html` two times and name the copies:
    - `page2.html`
    - `page3.html`  
      (Both should also be inside the `pages` directory.)

9. **Move** the file `page2.html` up one level (to the directory `tmp_website`).

10. **Delete** the files `index.html`, `page1.html`, and `page3.html`.

11. **Rename** the file `page2.html` to `index.html`.

12. **Delete** the (empty) directory `pages`.

13. **Delete** the (non-empty) directory `tmp_website`.

#### solution : 
```bash
[mohammad@localhost Desktop]$ mkdir tmp_website 
[mohammad@localhost Desktop]$ touch index.html style.css script.js
[mohammad@localhost Desktop]$ mkdir styles 
[mohammad@localhost Desktop]$ mv *.css styles 
[mohammad@localhost Desktop]$ ls
index.html  script.js  styles  tmp_website
[mohammad@localhost Desktop]$ ls styles/
style.css
[mohammad@localhost Desktop]$ mkdir scripts 
[mohammad@localhost Desktop]$ mv *.js script
[mohammad@localhost Desktop]$ ls
index.html  script  scripts  styles  tmp_website
[mohammad@localhost Desktop]$ ls scripts 
[mohammad@localhost Desktop]$ rm script 
[mohammad@localhost Desktop]$ touch script.js 
[mohammad@localhost Desktop]$ mv script.js scripts 
[mohammad@localhost Desktop]$ ls 
index.html  scripts  styles  tmp_website
[mohammad@localhost Desktop]$ mv -r styles tmp_website/
mv: invalid option -- 'r'
Try 'mv --help' for more information.
[mohammad@localhost Desktop]$ mv styles tmp_website/
[mohammad@localhost Desktop]$ ls 
index.html  scripts  tmp_website
[mohammad@localhost Desktop]$ mv scripts tmp_website/
[mohammad@localhost Desktop]$ ls
index.html  tmp_website
[mohammad@localhost Desktop]$ mv index.html tmp_website/
[mohammad@localhost Desktop]$ ls 
tmp_website
[mohammad@localhost Desktop]$ cd tmp_website/
[mohammad@localhost tmp_website]$ touch page1.html 
[mohammad@localhost tmp_website]$ mkdir pages
[mohammad@localhost tmp_website]$ mv page1.html pages/ 
[mohammad@localhost tmp_website]$ ls 
index.html  pages  scripts  styles
[mohammad@localhost tmp_website]$ ls pages/
page1.html
[mohammad@localhost tmp_website]$ cd pages/
[mohammad@localhost pages]$ cp page1.html  page2.html page3.html 
cp: target 'page3.html' is not a directory
[mohammad@localhost pages]$ cp page1.html page2.html 
[mohammad@localhost pages]$ cp page1.html page3.html 
[mohammad@localhost pages]$ mv page2.html ./../
[mohammad@localhost pages]$ ls
page1.html  page3.html
[mohammad@localhost pages]$ ls ..
index.html  page2.html  pages  scripts  styles
[mohammad@localhost pages]$ rm ./../index.html page3.html page1.html 
[mohammad@localhost pages]$ ls 
[mohammad@localhost pages]$ ls 
[mohammad@localhost pages]$ cd ..
[mohammad@localhost tmp_website]$ ls 
page2.html  pages  scripts  styles
[mohammad@localhost tmp_website]$ mv page2.html index.html 
[mohammad@localhost tmp_website]$ ls 
index.html  pages  scripts  styles
[mohammad@localhost tmp_website]$ rmdir page s
rmdir: failed to remove 'page': No such file or directory
rmdir: failed to remove 's': No such file or directory
[mohammad@localhost tmp_website]$ rmdir pages
[mohammad@localhost tmp_website]$ cd ..
[mohammad@localhost Desktop]$ rmdir tmp_website/
rmdir: failed to remove 'tmp_website/': Directory not empty
[mohammad@localhost Desktop]$ rmdir -r tmp_website/
rmdir: invalid option -- 'r'
Try 'rmdir --help' for more information.
[mohammad@localhost Desktop]$ rm -r tmp_website/
[mohammad@localhost Desktop]$ ls 
[mohammad@localhost Desktop]$ ls 
```

```bash
mohammad@ubuntu1:~$ cd Des
bash: cd: Des: No such file or directory
mohammad@ubuntu1:~$ cd Desktop/
mohammad@ubuntu1:~/Desktop$ mkdir tmp-website 
mohammad@ubuntu1:~/Desktop$ cd tmp-website/
mohammad@ubuntu1:~/Desktop/tmp-website$ touch index.html style.css script.js
mohammad@ubuntu1:~/Desktop/tmp-website$ mkdir styles
mohammad@ubuntu1:~/Desktop/tmp-website$ mv style.css styles/style.css 
mohammad@ubuntu1:~/Desktop/tmp-website$ ls 
index.html  script.js  styles
mohammad@ubuntu1:~/Desktop/tmp-website$ mv index.html styles/ 
mohammad@ubuntu1:~/Desktop/tmp-website$ ls 
script.js  styles
mohammad@ubuntu1:~/Desktop/tmp-website$ mv styles/index.html . 
mohammad@ubuntu1:~/Desktop/tmp-website$ ls 
index.html  script.js  styles
mohammad@ubuntu1:~/Desktop/tmp-website$ ls styles/
style.css
mohammad@ubuntu1:~/Desktop/tmp-website$ mkdir scripts 
mohammad@ubuntu1:~/Desktop/tmp-website$ mv script
script.js  scripts/   
mohammad@ubuntu1:~/Desktop/tmp-website$ mv script.js scripts/index.js 
mohammad@ubuntu1:~/Desktop/tmp-website$ ls scripts/
index.js
mohammad@ubuntu1:~/Desktop/tmp-website$ mkdir pages
mohammad@ubuntu1:~/Desktop/tmp-website$ cd pages
mohammad@ubuntu1:~/Desktop/tmp-website/pages$ touch page1.html 
mohammad@ubuntu1:~/Desktop/tmp-website/pages$ cp page1.html page2.html 
mohammad@ubuntu1:~/Desktop/tmp-website/pages$ cp page1.html page3.html 
mohammad@ubuntu1:~/Desktop/tmp-website/pages$ mv page2.html .. 
mohammad@ubuntu1:~/Desktop/tmp-website/pages$ cd ..
mohammad@ubuntu1:~/Desktop/tmp-website$ ls 
index.html  page2.html  pages  scripts  styles
mohammad@ubuntu1:~/Desktop/tmp-website$ rm index.html 
mohammad@ubuntu1:~/Desktop/tmp-website$ rm pages/* 
mohammad@ubuntu1:~/Desktop/tmp-website$ ls pages
mohammad@ubuntu1:~/Desktop/tmp-website$ mv page2.html index.html 
mohammad@ubuntu1:~/Desktop/tmp-website$ rm -d pages/
mohammad@ubuntu1:~/Desktop/tmp-website$ ls 
index.html  scripts  styles
mohammad@ubuntu1:~/Desktop/tmp-website$ rm -rf . 
rm: refusing to remove '.' or '..' directory: skipping '.'
mohammad@ubuntu1:~/Desktop/tmp-website$ cd ..
mohammad@ubuntu1:~/Desktop$ rm -rf tmp-website/
mohammad@ubuntu1:~/Desktop$ ls 
access.log  download-slow  script.sh
mohammad@ubuntu1:~/Desktop$ ^C
mohammad@ubuntu1:~/Desktop$ 
```
