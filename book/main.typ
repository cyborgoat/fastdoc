#import "src/book.typ": *
#import "src/chapter1.typ": *
#import "src/chapter2.typ": *
#import "src/chapter3.typ": *
#import "src/book-cover.typ": *

// Book cover page
#book-cover(
  title: "我是个惊喜",
  subtitle: "A Comprehensive Technical Manual",
  authors: ("Junxiao Guo", "Technical Expert"),
  version: "1.0.0",
  publisher: "Technical Publications",
  logo-path: "logo.jpg",
  accent-color: "#2563eb",
)

#pagebreak()

// Main book configuration
#show: book.with(
  title: "Modern Software Development Guide",
  subtitle: "A Comprehensive Technical Manual",
  authors: ("Junxiao Guo", "Technical Expert"),
  version: "1.0.0",
  date: datetime.today(),
  publisher: "Technical Publications",
  isbn: "978-0-123456-78-9",
  accent-color: "#2563eb",
  font: "New Computer Modern",
  paper: "a4",
  show-outline: true,
  show-bibliography: true,
)

// Include content chapters
#chapter-introduction()
#chapter-getting-started()
#chapter-core-concepts()
#chapter-mathematical-foundations()
#chapter-advanced-practices()

// Additional chapters can be added here
= Advanced Topics

This chapter would cover more sophisticated concepts and techniques.

== Microservices Architecture

Modern applications often benefit from a microservices approach, where the application is decomposed into smaller, independent services. This architectural pattern aligns with principles outlined in design patterns literature @gamma1994.

#callout(type: "info", title: "Microservices Benefits")[
  - Independent deployment and scaling
  - Technology diversity
  - Fault isolation
  - Team autonomy
]

== Clean Code Principles

Writing maintainable code is essential for long-term project success. As emphasized by @martin2008, clean code should be readable, simple, and well-structured. Key principles include:

1. *Meaningful names*: Choose descriptive variable and function names
2. *Small functions*: Keep functions focused on a single responsibility  
3. *No duplication*: Follow the DRY (Don't Repeat Yourself) principle
4. *Clear comments*: Write comments that explain why, not what

The pragmatic approach to software development @hunt1999 emphasizes the importance of being adaptable and practical in your coding practices.

== Test-Driven Development

Test-Driven Development (TDD) is a software development methodology that has gained significant traction. As described by @beck2002, TDD follows a simple cycle:

1. Write a failing test
2. Write the minimal code to make the test pass
3. Refactor the code while keeping tests green

This approach helps ensure code quality and maintainability throughout the development process.

== Refactoring Strategies

Improving existing code without changing its external behavior is crucial for maintaining software quality. @fowler1999 provides comprehensive guidance on refactoring techniques that help developers:

- Improve code structure
- Reduce complexity
- Enhance readability
- Eliminate code smells

== Container Orchestration

```yaml
# docker-compose.yml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DEBUG=1
    depends_on:
      - db
  
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

#text(size: 0.9em, style: "italic")[Docker Compose configuration for a web application]

== API Design Best Practices

When designing APIs, consider these principles based on industry best practices and software engineering fundamentals @mcconnell2004:

1. *RESTful conventions*: Use HTTP methods appropriately
2. *Consistent naming*: Follow a clear naming scheme  
3. *Versioning*: Plan for API evolution
4. *Documentation*: Provide comprehensive API docs
5. *Error handling*: Return meaningful error messages

The importance of structured programming @dijkstra1968 applies to API design as well - avoid complex control flows and maintain clear, predictable interfaces.

#callout(
  type: "note", 
  title: "API Reference: GET /api/v1/users",
)[
  *Signature:* `GET /api/v1/users?page=1&limit=20`
  
  *Description:* Retrieve a paginated list of users.
  
  *Parameters:*
  - `page` (int): Page number (default: 1)
  - `limit` (int): Items per page (default: 20, max: 100)
  - `search` (string): Search query for filtering users
  
  *Returns:* JSON object with users array and pagination metadata
  
  *Examples:*
  - `curl -X GET 'https://api.example.com/v1/users?page=1&limit=10'`
  - `curl -X GET 'https://api.example.com/v1/users?search=john&limit=5'`
]

= Performance Optimization

Performance is crucial for user experience and system scalability.

== Database Optimization

#styled-table(
  columns: 3,
  [*Technique*], [*Use Case*], [*Impact*],
  [Indexing], [Frequent queries], [High],
  [Query optimization], [Complex joins], [High],
  [Connection pooling], [High concurrency], [Medium],
  [Caching], [Read-heavy workloads], [High],
  [Partitioning], [Large tables], [Medium],
)

== Caching Strategies

#callout(type: "success", title: "Caching Levels")[
  Implement caching at multiple levels for optimal performance:
  - Browser cache (client-side)
  - CDN cache (edge locations)
  - Application cache (in-memory)
  - Database cache (query results)
]

= Security Considerations

Security should be built into every layer of your application. As noted in software engineering literature @brooks1987, there is no silver bullet for software complexity, and security is one of the essential complexities that must be carefully addressed.

== Authentication and Authorization

Proper authentication and authorization mechanisms are fundamental to application security. Consider these implementation approaches based on industry standards:

```python
from functools import wraps
from flask import request, jsonify
import jwt

def require_auth(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.headers.get('Authorization')
        if not token:
            return jsonify({'error': 'No token provided'}), 401
        
        try:
            # Remove 'Bearer ' prefix
            token = token.split(' ')[1]
            payload = jwt.decode(token, app.config['SECRET_KEY'], 
                              algorithms=['HS256'])
            current_user = payload['user_id']
        except (jwt.InvalidTokenError, KeyError):
            return jsonify({'error': 'Invalid token'}), 401
        
        return f(current_user, *args, **kwargs)
    return decorated_function

@app.route('/api/protected')
@require_auth
def protected_route(current_user):
    return jsonify({'message': f'Hello user {current_user}'})
```

#text(size: 0.9em, style: "italic")[JWT authentication decorator in Flask]

== Input Validation

#callout(type: "danger", title: "Security Warning")[
  Never trust user input. Always validate and sanitize data before processing or storing it. This prevents injection attacks and data corruption.
]

= Testing and Quality Assurance

Comprehensive testing ensures your code works correctly and continues to work as you make changes.

== Documentation Best Practices

Good documentation is essential for maintainable software. Well-documented codebases, like the Python documentation @python-docs, serve as excellent examples of clear, comprehensive technical writing. The concept of literate programming @knuth1984 emphasizes the importance of writing code that humans can understand, not just computers.

Key documentation principles include:

- *Clarity*: Write for your audience's knowledge level
- *Completeness*: Cover all important functionality
- *Examples*: Provide practical usage examples
- *Maintenance*: Keep documentation up to date with code changes

== Test Pyramid

The test pyramid suggests the proportion of different types of tests:

1. *Unit Tests* (70%): Fast, focused tests for individual functions
2. *Integration Tests* (20%): Test interactions between components  
3. *End-to-End Tests* (10%): Test complete user workflows

== Continuous Integration

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
        pip install -r requirements-dev.txt
    
    - name: Run tests
      run: |
        python -m pytest tests/ --cov=src/ --cov-report=xml
    
    - name: Upload coverage
      uses: codecov/codecov-action@v3
```

#text(size: 0.9em, style: "italic")[GitHub Actions CI/CD configuration]

= Deployment and DevOps

Modern deployment practices ensure reliable and efficient software delivery.

== Infrastructure as Code

```terraform
# main.tf
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl start docker
    systemctl enable docker
  EOF
  
  tags = {
    Name        = "WebServer"
    Environment = "production"
  }
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}
```

#text(size: 0.9em, style: "italic")[Terraform configuration for AWS infrastructure]

== Monitoring and Logging

#callout(type: "info", title: "Observability")[
  Implement the three pillars of observability:
  - *Metrics*: Quantitative measurements of system behavior
  - *Logs*: Detailed records of events and errors
  - *Traces*: Track requests through distributed systems
]

= Conclusion

This guide has covered the essential aspects of modern software development, from basic concepts to advanced deployment strategies. 

=== Key Takeaways

- Write clean, maintainable code following established patterns
- Implement comprehensive testing at all levels
- Prioritize security from the beginning
- Use modern deployment and monitoring practices
- Continue learning and adapting to new technologies

=== Next Steps

To continue your journey:

1. Practice implementing the patterns and techniques shown in this guide
2. Contribute to open-source projects to gain real-world experience
3. Stay updated with industry trends and best practices
4. Build a portfolio of projects demonstrating your skills

Thank you for reading this guide. We hope it serves as a valuable reference throughout your development career.

// Bibliography
#bibliography("src/references.bib", title: "References", style: "ieee")
