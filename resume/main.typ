#import "src/lib.typ": *
#import "src/resume.typ": *

// Put your personal information here, replacing mine
#let name = "Junxiao Guo"
#let location = "Mars"
#let email = "your_email@somewhere.com"
#let github = "github.com/cyborgoat"
#let linkedin = "https://www.linkedin.com/in/junxiaog/"
#let phone = "+1 (xxx) xxx-xxxx"
#let personal-site = "https://cyborgoat.github.io/"

#show: resume.with(
  author: name,
  // All the lines below are optional.
  // For example, if you want to to hide your phone number:
  // feel free to comment those lines out and they will not show.
  location: location,
  email: email,
  github: github,
  linkedin: linkedin,
  phone: phone,
  personal-site: personal-site,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
)

/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "", consistent: false)
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* certificates(name: "", issuer: "", url: "", date: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/
== Education


#edu(
  institution: "Carnegie Mellon University",
  location: "Pittsburgh, PA",
  dates: dates-helper(start-date: "2018", end-date: "2020"),
  degree: "Master of Science, Electrical and Computer Engineering",
)

#edu(
  institution: "Drexel University",
  location: "Philadelphia, PA",
  dates: dates-helper(start-date: "2013", end-date: "2017"),
  degree: "Bachelor of Science, Physics",
)

== Work Experience


#work(
  title: "Technical Manager",
  location: "Beijing, China",
  company: "Huawei",
  dates: dates-helper(start-date: "Sep 2024", end-date: "Present"),
)

#work(
  title: "Project Lead",
  location: "Beijing, China",
  company: "Huawei",
  dates: dates-helper(start-date: "Mar 2022", end-date: "Sep 2024"),
)

#work(
  title: "Senior Algorithm Engineer",
  location: "Beijing, China",
  company: "Huawei",
  dates: dates-helper(start-date: "Sep 2021", end-date: "Mar 2022"),
)

#work(
  title: "Data System Engineer (Intern)",
  location: "Shanghai, China",
  company: "NIO",
  dates: dates-helper(start-date: "May 2019", end-date: "Aug 2019"),
)
- Built time series models for route prediction.

#work(
  title: "Research Assistant",
  location: "Chongqing, China",
  company: "Chinese Academy of Sciences",
  dates: dates-helper(start-date: "May 2018", end-date: "Dec 2018"),
)
- Executed research on recommender system, proposed Elastic-net-regularized Latent-Factor-Analysis-based models for recommender system on HiDS matrix datasets.

== Projects


#project(
  name: "Assembly Interpreter",
  dates: dates-helper(start-date: "Jan 2020", end-date: "Feb 2020"),
  url: "",
)
- Designed a system able to parse and execute programs written in the assembly language, and model the behavior of the programs as if they were executing on a simple computer processor.

#project(
  name: "Cryptarithm Solver",
  dates: dates-helper(start-date: "Jan 2020", end-date: "Feb 2020"),
  url: "",
)
- Constructed a cryptarithm solver system. The system includes context parser, an efficient general-purpose permutation generator using Heap's algorithm, a context expression converter, a calculation operator and more.
#extracurriculars(
  activity: "Capture The Flag Competitions",
  dates: dates-helper(start-date: "Jan 2021", end-date: "Present"),
)

== Skills
- *REST APIs*: Passed LinkedIn Skill Assessment
- *Machine Learning*: Passed LinkedIn Skill Assessment, 1 endorsement

== Publications

*Elastic-net regularized latent factor analysis-based models for recommender systems*, Neurocomputing, Feb 15, 2019

== Skills
- *Programming Languages*: JavaScript, Python, C/C++, HTML/CSS, Java, Bash, R, Flutter, Dart
- *Technologies*: React, Astro, Svelte, Tailwind CSS, Git, UNIX, Docker, Caddy, NGINX, Google Cloud Platform
