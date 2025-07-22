// Chapter 1: Sample content chapters for the technical book
// This file contains multiple chapter functions: Introduction, Getting Started, and Core Concepts
#import "lib.typ": *

// Chapter 1: Introduction
#let chapter-introduction() = [
  = Introduction

  Welcome to this comprehensive technical guide. This book aims to provide you with practical knowledge and hands-on experience in modern software development practices.

  == What You'll Learn

  Throughout this book, you will discover:

  - Modern development methodologies and best practices
  - Advanced programming techniques and patterns
  - System design principles and architectural considerations
  - Performance optimization strategies
  - Testing and quality assurance approaches

  == Prerequisites

  #callout(type: "info", title: "Before You Begin")[
    This book assumes you have:
    - Basic programming knowledge in Python or JavaScript
    - Familiarity with command-line interfaces
    - Understanding of fundamental computer science concepts
  ]

  == How to Use This Book

  Each chapter builds upon the previous ones, so we recommend reading them in order. However, experienced developers may jump to specific topics of interest.

  #callout(type: "warning", title: "Code Examples")[
    All code examples in this book are tested and verified. Make sure to follow the setup instructions in the next chapter before running any examples.
  ]

  == Getting Help

  If you encounter any issues while following this guide:

  1. Check the troubleshooting section at the end of each chapter
  2. Visit our online documentation at `https://example.com/docs`
  3. Join our community forum for discussion and support

  Let's begin this journey together!
]

// Chapter 2: Getting Started
#let chapter-getting-started() = [
  = Getting Started

  This chapter will guide you through setting up your development environment and running your first example.

  == Environment Setup

  #callout(
    type: "info", 
    title: "Step 1: Install Required Tools",
  )[
    First, ensure you have the following tools installed on your system:

    ```bash
    # Check Python version (3.8+ required)
    python --version

    # Check pip installation
    pip --version

    # Check git installation
    git --version
    ```
  ]

  #callout(
    type: "info", 
    title: "Step 2: Clone the Repository",
  )[
    Download the example code repository:

    ```bash
    git clone https://github.com/example/technical-guide.git
    cd technical-guide
    ```
  ]

  #callout(
    type: "info", 
    title: "Step 3: Install Dependencies",
  )[
    Install the required Python packages:

    ```bash
    pip install -r requirements.txt
    ```
  ]

  == Your First Example

  Let's start with a simple "Hello World" example to verify everything is working correctly.

  ```python
  # hello.py
  def greet(name="World"):
      """
      A simple greeting function.
      
      Args:
          name (str): The name to greet
          
      Returns:
          str: A greeting message
      """
      return f"Hello, {name}!"

  if __name__ == "__main__":
      print(greet())
      print(greet("Developer"))
  ```

  #text(size: 0.9em, style: "italic")[A simple Python greeting function]

  Run this example:

  ```bash
  python hello.py
  ```

  You should see:
  ```
  Hello, World!
  Hello, Developer!
  ```

  #callout(type: "success", title: "Congratulations!")[
    If you see the expected output, your environment is set up correctly and you're ready to proceed to the next chapter.
  ]

  == Troubleshooting

  === Python Not Found
  If you get a "python command not found" error, try using `python3` instead of `python`.

  === Permission Errors
  On macOS and Linux, you might need to use `sudo` for system-wide installations, or consider using virtual environments.

  === Module Import Errors
  Ensure you're in the correct directory and all dependencies are installed.
]

// Chapter 3: Core Concepts
#let chapter-core-concepts() = [
  = Core Concepts

  This chapter introduces the fundamental concepts that form the foundation of our technical approach.

  == Design Patterns

  Design patterns are reusable solutions to common problems in software design. Let's explore some essential patterns.

  === Singleton Pattern

  The Singleton pattern ensures a class has only one instance and provides global access to it.

  ```python
  class DatabaseConnection:
      _instance = None
      _connection = None
      
      def __new__(cls):
          if cls._instance is None:
              cls._instance = super().__new__(cls)
          return cls._instance
      
      def connect(self):
          if self._connection is None:
              self._connection = "Connected to database"
              print(self._connection)
          return self._connection

  # Usage
  db1 = DatabaseConnection()
  db2 = DatabaseConnection()
  print(db1 is db2)  # True - same instance
  ```

  #text(size: 0.9em, style: "italic")[Singleton pattern implementation]

  === Factory Pattern

  The Factory pattern creates objects without specifying their exact classes.

  #callout(
    type: "note", 
    title: "API Reference: create_vehicle",
  )[
    *Signature:* `create_vehicle(vehicle_type: str, **kwargs) -> Vehicle`
    
    *Description:* Factory function to create different types of vehicles.
    
    *Parameters:*
    - `vehicle_type` (str): Type of vehicle ('car', 'truck', 'motorcycle')
    - `kwargs` (dict): Additional parameters for vehicle configuration
    
    *Returns:* Vehicle instance of the specified type
    
    *Examples:*
    - `car = create_vehicle('car', brand='Toyota', model='Camry')`
    - `truck = create_vehicle('truck', capacity=5000)`
  ]

  == Error Handling

  Proper error handling is crucial for robust applications.

  #callout(type: "warning", title: "Best Practice")[
    Always handle specific exceptions rather than using bare `except:` clauses. This makes debugging easier and prevents hiding unexpected errors.
  ]

  ```python
  def safe_divide(a, b):
      try:
          result = a / b
          return result
      except ZeroDivisionError:
          print("Error: Division by zero!")
          return None
      except TypeError:
          print("Error: Invalid input types!")
          return None
      except Exception as e:
          print(f"Unexpected error: {e}")
          return None

  # Usage examples
  print(safe_divide(10, 2))    # 5.0
  print(safe_divide(10, 0))    # Error: Division by zero!
  print(safe_divide("10", 2))  # Error: Invalid input types!
  ```

  #text(size: 0.9em, style: "italic")[Robust error handling example]

  == Performance Considerations

  Writing efficient code is essential for scalable applications.

  === Time Complexity

  Understanding Big O notation helps you choose the right algorithms:

  #styled-table(
    columns: 3,
    [*Complexity*], [*Description*], [*Example*],
    [O(1)], [Constant time], [Array access by index],
    [O(log n)], [Logarithmic time], [Binary search],
    [O(n)], [Linear time], [Linear search],
    [O(n log n)], [Linearithmic time], [Merge sort],
    [O(n²)], [Quadratic time], [Nested loops],
  )

  === Memory Management

  #callout(type: "info", title: "Python Memory Tips")[
    - Use generators for large datasets to save memory
    - Be aware of circular references that can prevent garbage collection
    - Consider using `__slots__` for classes with many instances
  ]

  == Testing Strategies

  Testing ensures your code works correctly and helps prevent regressions.

  === Unit Testing

  ```python
  import unittest

  class TestMathOperations(unittest.TestCase):
      
      def test_addition(self):
          self.assertEqual(add(2, 3), 5)
          self.assertEqual(add(-1, 1), 0)
          
      def test_division(self):
          self.assertEqual(divide(10, 2), 5)
          with self.assertRaises(ZeroDivisionError):
              divide(10, 0)

  if __name__ == '__main__':
      unittest.main()
  ```

  #text(size: 0.9em, style: "italic")[Unit testing example with unittest]

  This chapter covered the essential concepts you'll need throughout this book. In the next chapter, we'll dive into practical applications of these concepts.
]
