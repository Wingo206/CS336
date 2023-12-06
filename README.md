# CS336 (Intro to Information and Data Management) Project

## Prerequisites
[MySQL Community Server](https://dev.mysql.com/downloads/mysql/)
- Set password as 'root'
- If you wish to use another username/password for JDBC connection
    - Go to **cs336Project\WEB-INF\classes\com\cs336\pkg\ApplicationDB.java**
    - modify `connection = DriverManager.getConnection(connectionUrl,"<username>", "<password>");`
    - Recompile with `javac ApplicationDB.java`

[MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

[VS Code](https://code.visualstudio.com/download)
- [Debugger For Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-debug)
- [Community Server Connectors](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-community-server-connector)

## Setup
1. Clone repo to VS Code
2. Use MySQL Workbench to execute the included **schema.sql** script to setup database
    2a. If you already have a database named "cs336db":
    2b. login to the MySQL Command Line Client and run `drop database cs336db;`
3. Use Community Server Connecter under **SERVERS** to `Create New Server...`
4. Select **Apache Tomcat 8.5.50**
5. Right click the newly created server to `Add Deployment` of project root directory
6. Right click to `Publish Server (Full)` so that the server is **(Synchronized)** and `Start Server`
7. Go to `http://localhost:8080/cs336Project/` in web browser

## Startup
### Customer
- Register an account through the register page
- Login through the login page

### Admin
- Login with username `admin` and password `admin`

### Customer Representative
- Create a customer account
- Login with admin to change account type to `representative`


## Troubleshooting
- Issues with starting/stopping/restarting Apache Tomcat server
    - Use `netstat -a -o | grep 8080` to find the pid of services using the localhost:8080 port
    - Terminate the service with task manager
