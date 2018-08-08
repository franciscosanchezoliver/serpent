package com.mycompany.app;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxBinary;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;

import java.util.concurrent.TimeUnit;

public class App {
  public static void main(String [] args) {
    
    System.out.println("Empezando programa");
    FirefoxBinary firefoxBinary = new FirefoxBinary();
    firefoxBinary.addCommandLineOptions("--headless");

    System.out.println("Poniendo gecko como webdriver");
    System.setProperty("webdriver.gecko.driver", "/usr/local/bin/geckodriver");
    FirefoxOptions firefoxOptions = new FirefoxOptions();
    firefoxOptions.setBinary(firefoxBinary);
    FirefoxDriver driver = new FirefoxDriver(firefoxOptions);
    try {
      System.out.println("Intentando acceder a google.com");
      driver.get("http://www.google.com");
      driver.manage().timeouts().implicitlyWait(4,TimeUnit.SECONDS);
      System.out.println("El titulo es :" + driver.getTitle());
      System.out.println("Google visitado!");
    }
    catch(Exception e){
       System.out.println("Ha ocurrido un error");
       e.printStackTrace();
    }
    finally {
      driver.quit();
      System.out.println("Fin del programa");
    }
  }
}
