// Chapter 3: Mathematical Foundations and Analysis
#import "lib.typ": *

#let chapter-mathematical-foundations() = [
  = Mathematical Foundations in Software Engineering

  Mathematics plays a crucial role in software engineering, from algorithm analysis to performance optimization. This chapter explores key mathematical concepts that every software engineer should understand.

  == Algorithm Complexity Analysis

  Understanding the mathematical foundations of algorithm complexity is essential for writing efficient code. The Big O notation provides a framework for analyzing algorithm performance.

  === Time Complexity

  The time complexity of an algorithm describes how the runtime grows with input size. Common complexity classes include:

  $ T(n) = O(1) $ - Constant time complexity

  $ T(n) = O(log n) $ - Logarithmic time complexity  

  $ T(n) = O(n) $ - Linear time complexity

  $ T(n) = O(n log n) $ - Linearithmic time complexity

  $ T(n) = O(n^2) $ - Quadratic time complexity

  $ T(n) = O(2^n) $ - Exponential time complexity

  #callout(type: "info", title: "Master Theorem")[
    For divide-and-conquer algorithms with recurrence relation:
    $ T(n) = a T(n/b) + f(n) $
    
    Where $a ≥ 1$, $b > 1$, and $f(n)$ is asymptotically positive.
  ]

  == Probability and Statistics in Software Systems

  Probabilistic analysis helps in understanding system behavior under uncertainty and designing robust applications.

  === Bayesian Inference

  Bayesian probability provides a framework for updating beliefs based on new evidence:

  $ P(A|B) = (P(B|A) × P(A)) / P(B) $

  Where:
  - $P(A|B)$ is the posterior probability
  - $P(B|A)$ is the likelihood  
  - $P(A)$ is the prior probability
  - $P(B)$ is the marginal probability

  === Performance Metrics

  System performance can be modeled using statistical distributions:

  $ "Response Time" = mu + sigma × Z $

  Where $mu$ is the mean response time, $sigma$ is the standard deviation, and $Z$ is the standard normal variable.

  #figure(
    image("example_img.jpeg", width: 80%),
    caption: [Example visualization of system performance metrics and mathematical relationships in software engineering applications.]
  )

  == Linear Algebra in Machine Learning

  Linear algebra forms the foundation of machine learning algorithms used in modern software systems.

  === Matrix Operations

  Vector and matrix operations are fundamental to many algorithms:

  $ bold(A) bold(x) = bold(b) $

  Where $bold(A)$ is an $n times n$ matrix, $bold(x)$ is the solution vector, and $bold(b)$ is the result vector.

  === Eigenvalues and Eigenvectors

  For a square matrix $bold(A)$, eigenvalues $lambda$ and eigenvectors $bold(v)$ satisfy:

  $ bold(A) bold(v) = lambda bold(v) $

  This relationship is crucial in:
  - Principal Component Analysis (PCA)
  - PageRank algorithm
  - Stability analysis of systems

  == Calculus in Optimization

  Calculus concepts are essential for optimization problems in software engineering.

  === Gradient Descent

  The gradient descent algorithm uses derivatives to find optimal solutions:

  $ x_(n+1) = x_n - alpha nabla f(x_n) $

  Where:
  - $alpha$ is the learning rate
  - $nabla f(x_n)$ is the gradient at point $x_n$

  === Taylor Series Approximation

  Many numerical algorithms use Taylor series for approximations:

  $ f(x) = sum_(n=0)^infinity (f^((n))(a))/(n!) (x-a)^n $

  #code-block(
    lang: "python",
    caption: "Implementing gradient descent optimization",
    "def gradient_descent(f, df, x0, learning_rate=0.01, max_iterations=1000):
    \"\"\"
    Minimize function f using gradient descent.
    
    Args:
        f: Function to minimize
        df: Gradient of the function
        x0: Starting point
        learning_rate: Step size
        max_iterations: Maximum number of iterations
    
    Returns:
        Optimal point and function value
    \"\"\"
    x = x0
    for i in range(max_iterations):
        gradient = df(x)
        x = x - learning_rate * gradient
        
        # Check convergence
        if abs(gradient) < 1e-6:
            break
    
    return x, f(x)

# Example: Minimize f(x) = x^2 + 2x + 1
def f(x):
    return x**2 + 2*x + 1

def df(x):
    return 2*x + 2

optimal_x, optimal_value = gradient_descent(f, df, x0=10)
print(f\"Optimal point: {optimal_x}, Optimal value: {optimal_value}\")"
  )

  == Discrete Mathematics and Logic

  Discrete mathematics provides the theoretical foundation for computer science algorithms and data structures.

  === Boolean Algebra

  Boolean operations form the basis of digital logic:

  $ A and B = A ∧ B $
  $ A or B = A ∨ B $  
  $ not A = ¬A $

  De Morgan's Laws:
  $ ¬(A ∧ B) = ¬A ∨ ¬B $
  $ ¬(A ∨ B) = ¬A ∧ ¬B $

  === Graph Theory

  Many software engineering problems can be modeled as graphs:

  $ G = (V, E) $

  Where $V$ is the set of vertices and $E$ is the set of edges.

  #callout(type: "note", title: "Shortest Path Algorithm")[
    Dijkstra's algorithm finds shortest paths with time complexity:
    $ O((|V| + |E|) log |V|) $
    
    Using a binary heap implementation.
  ]

  == Cryptography and Number Theory

  Modern security relies heavily on mathematical concepts from number theory.

  === Modular Arithmetic

  Modular arithmetic is fundamental to cryptographic algorithms:

  $ a ≡ b space (mod space m) $

  This means $m$ divides $(a - b)$.

  === RSA Encryption

  The RSA algorithm relies on the difficulty of factoring large numbers:

  $ c = m^e space (mod space n) $
  $ m = c^d space (mod space n) $

  Where $(e, n)$ is the public key and $(d, n)$ is the private key.

  #styled-table(
    columns: 4,
    [*Concept*], [*Mathematical Foundation*], [*Application*], [*Complexity*],
    [Sorting], [Comparison theory], [Data organization], [O(n log n)],
    [Hashing], [Number theory], [Fast lookup], [O(1) average],
    [Encryption], [Modular arithmetic], [Security], [O(log n)],
    [Machine Learning], [Linear algebra], [AI systems], [O(n³) typical],
    [Graph algorithms], [Graph theory], [Network analysis], [O(V + E)],
  )

  == Practical Applications

  These mathematical concepts directly apply to software engineering:

  1. *Algorithm Design*: Use complexity analysis to choose appropriate algorithms
  2. *Performance Optimization*: Apply calculus concepts for optimization problems  
  3. *Security Implementation*: Leverage number theory for cryptographic systems
  4. *Data Analysis*: Use statistics and probability for system monitoring
  5. *Machine Learning*: Apply linear algebra for AI/ML implementations

  #callout(type: "success", title: "Key Takeaway")[
    Mathematics is not just theoretical—it's a practical toolkit for solving real-world software engineering problems. Understanding these concepts enables you to make informed decisions about algorithm choice, system design, and performance optimization.
  ]
]
