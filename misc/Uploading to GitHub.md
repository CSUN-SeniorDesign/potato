## Uploading to GitHub

## Table of Contents
- Section 1: Installation

- Section 2: First time setup

- Section 3: Updating the repository

### Section 1: Installation

#### Installing a GUI for GIT

tl;dr: Keep all defaults and click next through everything.

1. Visit ```https://git-scm.com/downloads``` and download the intaller for your operating system.
2. Once downloaded, run the installer.
3. At the license, click next.

  ![Git Bash 1](../markdown-images/git-guide/1.png)

4. Leave the install location as the default and click next.  

  ![Git Bash 2](../markdown-images/git-guide/2.png)

5. Leave the components as the default and click next.

  ![Git Bash 3](../markdown-images/git-guide/3.png)

6. Leave the start menu folder as the default and click next.

  ![Git Bash 4](../markdown-images/git-guide/4.png)

7. Leave the default editor as the default and click next.

  ![Git Bash 5](../markdown-images/git-guide/5.png)

8. Leave the PATH environment as the default and click next.

  ![Git Bash 6](../markdown-images/git-guide/6.png)

9. Leave the SSH executable as the default and click next.

  ![Git Bash 7](../markdown-images/git-guide/7.png)

10. Leave the HTTPS transport backend as the default and click next.

  ![Git Bash 8](../markdown-images/git-guide/8.png)

11. Leave the line ending conversions as default and click next.

  ![Git Bash 9](../markdown-images/git-guide/9.png)

12. Leave the terminal emulator as default and click next.

  ![Git Bash 10](../markdown-images/git-guide/10.png)

13. Leave the extra options as default and click next.

  ![Git Bash 11](../markdown-images/git-guide/11.png)

14. Leave the experimental options as default and click install.

  ![Git Bash 12](../markdown-images/git-guide/12.png)

### Section 2: First time setup

#### Adding a repository to your local machine (Cloning)

There are two methods to clone a GitHub repository to your local machine.

Note: This only needs to be done once.

##### Method 1: With the GUI

1. Open an explorer to the location where you want to create your local copy of the GitHub repository.

  ![Git Bash 13](../markdown-images/git-guide/13.png)

2. Right click on the whitespace and click ```Git GUI Here```

  ![Git Bash 14](../markdown-images/git-guide/14.png)

3. Click ```Clone Existing Repository```

  ![Git Bash 17](../markdown-images/git-guide/17.png)

4. For the source location copy and paste the "top level" of the GitHub repository ```https://github.com/CSUN-Irrigation/software-irrigation```
5. For the target directory copy and paste the location where you want the repository to be copied to on your local machine. Mine was ```D:\Work\Google Drive\CSUN\Fall 2018\CIT 480\CIT 480 Final Project\software-irrigation```

  Note: Unlike the method using CLI, here you should include the folder name that's the same as the repository name. (software-irrigation)
6. Press ```Clone```

  ![Git Bash 18](../markdown-images/git-guide/18.png)

##### Method 2: With CLI

1. Open an explorer to the location where you want to create your local copy of the GitHub repository.

  ![Git Bash 13](../markdown-images/git-guide/13.png)

2. Right click on the whitespace and click ```Git Bash Here```

  ![Git Bash 14](../markdown-images/git-guide/14.png)

3. Type ```git clone https://github.com/CSUN-Irrigation/software-irrigation``` and press enter.

  ![Git Bash 15](../markdown-images/git-guide/15.png)


  Hint:

  ```
  You can right click and press paste to paste long links.
  ```

  Warning:

  ```
  You have to give the link to the "top level" of a GitHub repository.
  ```

  Example:

  ```
  ```https://github.com/CSUN-Irrigation/software-irrigation``` is acceptable.

  ```https://github.com/CSUN-Irrigation/software-irrigation/tree/master/app``` is NOT acceptable.
  ```

4. The repository with the name ```software-irrigation``` should now be a folder in the directory you right clicked and opened the git CLI from.

  ![Git Bash 16](../markdown-images/git-guide/16.png)

### Section 3: Updating the repository
