## Setting up Gitlab Runner for Server
1. Downloading a script that will assist with the installation of Gitlab runner with this command:
```
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh -o /tmp/gl-runner.deb.sh
```
Then we will run the script:
```
sudo bash /tmp/gl-runner.deb.sh
```
###### The script lets us use the Gitlab maintained repositories as well as use the same package managment tools as our other system packages.

3. Install of Gitlab runner
```
sudo apt-get install gitlab-runner
```
###### After installing your will need to configure the runner through the Gitlab site.
Going to Gitlab > Settings > CI/CD > Runner Settings > Expand
You will see a registration token that you will need to copy.

4. To register the Runner type the command:
```
sudo gitlab-runner register
```
This command will take you through a couple of steps.
1. Enter your Gitlab server's domain name
2. Enter the Gitlab-ci token : This is the token you copied from step 3
3. Description for the runner : Giving a name for the runner.
4. Tag for the Runner : You can leave this blank or you can give it tags for it to be easily referenced.
5. Lock the Runner to the Current Project: This means the runner cannot be used for other projects. Typing "False" will allow it to be used by other projects.
6. Runner Executor : The method that the runner will be completing its jobs, Docker is a good choice.
7. Default Docker Image : Specify .gitlab-ci.yml

<br>
5. Finally Type the following command to see that the runner is available.

```
sudo gitlab-runner list
```
