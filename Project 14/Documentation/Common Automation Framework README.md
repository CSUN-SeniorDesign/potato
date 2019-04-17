# CommonAutomationFramework
An automation framework built with TestNG and Selenium to automate the testing of websites and web applications.

# Setting up an Automation Framework with Selenium and TestNG

## Setting up the Project with Maven in IntelliJ IDEA
The project will be managed with the software project management tool: Maven.

1. Start a Maven project by clicking on Create New Project.

2. Select the Maven tab then click Next.
3. Give a GroupID and an ArtifactID then click Next.
4. Give a Project Name and Location then click Finish.

## Adding Selenium, TestNG, and Other Tools to the Maven Project
1. Go to https://mvnrepository.com/
2. Type Selenium into the search bar and click on Selenium Java.
3. Click on version 3.141.x then copy the contents of the Maven tab to your clipboard.
4. In the Maven project's pom.xml file create a "dependencies" tag
5. Paste the contents of your clipboard inside the "dependencies" tag.
    ```
        <dependencies>
            <dependency>
                ...
            </dependency>
        </dependencies>
    </project>
    ```
6. Type TestNG into the search bar and click on Selenium Java.
7. Click on version 7.0.0-beta3 then copy the contents of the Maven tab to your clipboard.
8. Paste the contents of your clipboard inside the "dependencies" tag.
9. Type WebDriverManager into the search bar and click on WebDriverManger by io.github.bonigarcia
10. Click on version 3.4.0 then copy the contents of the Maven tab to your clipboard.
11. Paste the contents of your clipboard inside the "dependencies" tag.
12. When an artifact added to the Maven project you have to import the changes so either click on "Import Changes" everytime the popup appears or "Enable Auto-Import" just once to automatically import any changes.

    Final view of the pom file:
    ```
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>

        <groupId>Common-Automation-Framework</groupId>
        <artifactId>Common-Automation-Framework</artifactId>
        <version>1.0-SNAPSHOT</version>

        <properties>
            <maven.compiler.target>1.8</maven.compiler.target>
            <maven.compiler.source>1.8</maven.compiler.source>
        </properties>

        <dependencies>
            <!-- USED FOR THE BROWSER AUTOMATION -->
            <!-- https://mvnrepository.com/artifact/org.seleniumhq.selenium/selenium-java -->
            <dependency>
                <groupId>org.seleniumhq.selenium</groupId>
                <artifactId>selenium-java</artifactId>
                <version>3.141.59</version>
            </dependency>

            <!-- USED FOR CREATING/RUNNING TESTS -->
            <!-- https://mvnrepository.com/artifact/org.testng/testng -->
            <dependency>
                <groupId>org.testng</groupId>
                <artifactId>testng</artifactId>
                <version>7.0.0-beta3</version>
                <scope>test</scope>
            </dependency>

            <!-- USED FOR MANAGING THE WEBDRIVER -->
            <!-- https://mvnrepository.com/artifact/io.github.bonigarcia/webdrivermanager -->
            <dependency>
                <groupId>io.github.bonigarcia</groupId>
                <artifactId>webdrivermanager</artifactId>
                <version>3.4.0</version>
            </dependency>

            <!-- USED FOR BETTER REPORTING -->
            <!-- https://mvnrepository.com/artifact/com.aventstack/extentreports -->
            <dependency>
                <groupId>com.aventstack</groupId>
                <artifactId>extentreports</artifactId>
                <version>4.0.9</version>
            </dependency>

            <!-- USED FOR BETTER LOGGING -->
            <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-api -->
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-api</artifactId>
                <version>1.7.26</version>
            </dependency>

            <!-- USED FOR BETTER LOGGING -->
            <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-log4j12 -->
            <dependency>
                <groupId>org.slf4j</groupId>
                <artifactId>slf4j-log4j12</artifactId>
                <version>1.7.26</version>
                <scope>test</scope>
            </dependency>
        </dependencies>
    </project>
    ```
13. Setup log4j by creating a log4j.properties file in /src/main/resources/log4j.properties
14. In log4j.properties enter the following:
    ```
    # Set root logger level to DEBUG and its only appender to A1.
    log4j.rootLogger=INFO, A1

    # A1 is set to be a ConsoleAppender.
    log4j.appender.A1=org.apache.log4j.ConsoleAppender

    # A1 uses PatternLayout.
    log4j.appender.A1.layout=org.apache.log4j.PatternLayout
    log4j.appender.A1.layout.ConversionPattern=%-4r [%t] %-5p %c %x - %m%n
    ```

    If at any point you delete the test-output folder, go into Run > Edit Configurations > Templates > TestNG > Output Directory and put in any value within the project. Run the class then check that the reporting has outputed files to the default location of /projectname/test-output
15. Set up extent config by creating a file called extent-config.xml
    ```
    <?xml version="1.0" encoding="UTF-8"?>
    <extentreports>
        <configuration>
            <!-- report theme -->
            <!-- standard, dark -->
            <theme>dark</theme>

            <!-- document encoding -->
            <!-- defaults to UTF-8 -->
            <encoding>UTF-8</encoding>

            <!-- protocol for script and stylesheets -->
            <!-- defaults to https -->
            <protocol>https</protocol>

            <!-- title of the document -->
            <documentTitle>Extent Framework</documentTitle>

            <!-- report name - displayed at top-nav -->
            <reportName>Build 1</reportName>

            <!-- timestamp format -->
            <timeStampFormat>MMM dd, yyyy HH:mm:ss</timeStampFormat>

            <!-- custom javascript -->
            <scripts>
                <![CDATA[
                    $(document).ready(function() {

                    });
                ]]>
            </scripts>

            <!-- custom styles -->
            <styles>
                <![CDATA[

                ]]>
            </styles>
        </configuration>
    </extentreports>
    ```

## Creating a Common Framework using TestNG and Selenium
1. Create a package called com.common.framework in /src/test/java/
2. Create a Java file in the com.common.framework package.
3. Import org.openqa.selenium.*;
4. Add a private WebDriver variable and include a getter and setter.
5. Add methods that would be required over the course of a testing effort.
    ```
    package com.common.framework;

    import org.openqa.selenium.WebDriver;
    import org.openqa.selenium.WebElement;
    import org.testng.Assert;

    public class CommonTools {
        private WebDriver driver;

        public WebDriver getDriver() {
            return driver;
        }
        public void setDriver(WebDriver driver) {
            this.driver = driver;
        }

        public void GoToWebsite(String url) {
        }

        public boolean verifyPageTitle(String pageTitle) {
        }

        public void clickButton(WebElement button) {
        }

        public void clickButton(String buttonName) {
        }

        public void chooseDropdownOption(WebElement option) {
        }

        public void enterTextIntoTextbox(WebElement textbox, String text) {
        }

        public void dateTimeIntoTextbox(WebElement textbox, String text) {
        }

        public void phoneNumberIntoTextbox(WebElement textbox, String phoneNumber) {

        }
    }
    ```

## Using the Common Framework
1. Create a package called com.shifttest in /src/test/java/
2. Create a Java file in the com.shifttest package.
3. Import the following:
    ```
    import com.common.framework.CommonTools;
    import io.github.bonigarcia.wdm.WebDriverManager;
    import com.aventstack.extentreports.ExtentReports;
    import com.aventstack.extentreports.reporter.ExtentHtmlReporter;
    import com.aventstack.extentreports.ExtentTest;
    import com.aventstack.extentreports.Status;
    import org.openqa.selenium.chrome.ChromeDriver;
    import org.testng.annotations.AfterMethod;
    import org.testng.annotations.BeforeClass;
    import org.testng.annotations.BeforeMethod;
    import org.testng.annotations.Test;
    ```
4. Create a CommonTools object and call it framework.
5. Using the @BeforeClass, @BeforeMethod, @AfterMethod, and @Test annoations, create methods with helpful names.
    ```
    public class Buttons {
        private CommonTools framework;

        ExtentHtmlReporter reporter = new ExtentHtmlReporter("test-output/extent-reporting/build/name/Extent.html");
        ExtentReports extent = new ExtentReports();
        ExtentTest test;

        @BeforeClass
        public static void setupClass() {
            WebDriverManager.chromedriver().setup();
        }

        @BeforeMethod
        public void setUp() {
            framework = new CommonTools();
            framework.setDriver(new ChromeDriver());

            reporter.loadXMLConfig("extent-config.xml");
            extent.attachReporter(reporter);
            extent.setSystemInfo("OS", "Win10");
            extent.setSystemInfo("Browser", "Chrome");
        }

        @AfterMethod
        public void tearDown() {
            if(framework.getDriver() != null) {
                framework.getDriver().close();
                framework.getDriver().quit();
                extent.flush();
            }
        }

        @Test
        public void visitWebsiteTest() {
            test = extent.createTest("Visit Website Test");
            test.log(Status.INFO, "Visiting the website: http://shifttest.shiftedtech.com/components/button");

            framework.GoToWebsite("http://shifttest.shiftedtech.com/components/button");

            if(framework.verifyPageTitle("Button Testing – Shift Education of Technology")) {
                test.log(Status.PASS, "Test Passed, the title has been verified.");
            } else {
                test.log(Status.FAIL, "Test Failed, the title does not match the given title.");
            }

            test.log(Status.INFO, "Completed test.");
            extent.flush();
        }
    }
    ```
