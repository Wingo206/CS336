# CS336 (Intro to Information and Data Management) Project

## Prerequisites
[MySQL Community Server](https://dev.mysql.com/downloads/mysql/)
- Set password as 'root'
- If you wish to use another username/password for JDBC connection, modify **cs336Project\WEB-INF\classes\com\cs336\pkg\ApplicationDB.java**, and compile with `javac ApplicationDB.java`

[MySQL Workbench](https://dev.mysql.com/downloads/workbench/)

[VS Code](https://code.visualstudio.com/download)
- [Debugger For Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-debug)
- [Community Server Connectors](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-community-server-connector)

## Setup
- Use MySQL Workbench to execute included .sql script to setup database
- Clone repo to VS Code
- Use Community Server Connecter under **SERVERS** to `Create New Server...`
- Select Apache Tomcat 8.5.50
- Right click the newly created server to `Add Deployment` of project root directory
- Right click to `Publish Server (Full)` so that the server is **(Synchronized)** and `Start Server`
- Go to `http://localhost:8080/cs336Project/` in web browser
