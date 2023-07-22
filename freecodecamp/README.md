
Note: Most of the material below is from FreeCodeCamp except:
1. Using Apache Tomcat in place of Nginix for M1, M2. 

## The application that we are going to deploy to Kubernetes:
- What: 
  - Takes one sentence as input. Uses Text Analysis to alculate the emotion of the sentence. 
  - Consists of 3 microservices
    - SA-frontend: Nginx web server that serves ReactJS static files 
    - SA-webapp: a Java Web app that handles reqs from frontend
    - SA-logic: a python app that performs Sentiment Analysis 

## Dependencies:
_M1 M2 Installation only_
- JDK8
  - install:<br>
    `brew tap AdoptOpenJDK/openjdk`<br>
    `brew install adoptopenjdk8`

- Maven
  - install:<br>
    `brew install maven`<br>
_Set up environment variables_
- `vim ~/.zshrc`
- Add the following to your shell profile file to set up the environment variables:<br>
`  # JDK 8
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"`

`  # Maven
export MAVEN_HOME="/opt/homebrew/Cellar/maven/3.9.3/libexec"<br>
export PATH="$PATH:$MAVEN_HOME/bin"`

  - 
## Tools & Installations:
- Installed Apache Server Tomacat as an alternative to Nginix web server. 
  - Apache Tomcat is a web container where you can deploy your web application and you can test on the local Mac OS machine. http://localhost:8080
  - Once installed, start the Tomcat server,<br>
    `cd Downloads/apache-tomcat-10.1.11/bin`<br>
    `./startup.sh` # start the Tomcat server
  - When done, shut down the server.<br>
    `./shutdown.sh` 
  -  By default, the port on which Tomcat container hosts its web application is 8080. 
  -  If that 8080 port is already attached to another application or server, you can change the Tomcat port by going here:<br>
    `cd Downloads/apache-tomcat-10.1.11/conf/server.xml`
  -  For the serving of static files with Apache Tomcat part...once you create your build for the frontend service, move the `/build` folder to `Downloads/apache-tomcat-10.1.11/webapps/ROOT`. But, before you do that..make sure to turn off the web server first to avoid any file conflicts. Once you've copied and moved over `/build` , start the Apache Tomcat to apply the changes.
  
