## Setting up Selenium WebDriver with Eclipse and Maven in Java
1. After downloading, installing, and opening Eclipse, go to File > New > Project > Maven Project.
2. Click Next, then select Create a simple project (skip archetype selection)
3. Specify the GroupID, ArtifactID, Name, and Description.
4. Click Finish to create the project.
5. Open up pom.xml and add the following:
  ```
  <properties>
    <java.version>1.8</java.version>
  </properties>
  ```
  The above specifies that the current project is running on java version 1.8

6. Next go onto your browser and go to https://mvnrepository.com/
7. Find JUnit, Maven Surefire Plugin, Hamcrest-all, Selenium-Java, and WebDriverManager.
8. Copy each of the provided dependency declarations found on the pages listed above. They will look like this:
  ```
    <!-- https://mvnrepository.com/artifact/junit/junit -->
  	<dependency>
  	    <groupId>junit</groupId>
  	    <artifactId>junit</artifactId>
  	    <version>4.12</version>
  	    <scope>test</scope>
  	</dependency>
  ```
  The above tells Maven to go and download the dependency files required to use the features from each dependency. Once all the dependencies are all downloading, the project can be started.

## Creating a Selenium Framework using POM (Page Object Model)
1.
2.
3.
4.
5.
