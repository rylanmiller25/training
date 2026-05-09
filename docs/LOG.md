# Learning Log

Notes on each module as you work through it. Jot down what clicked, what didn't, gaps to revisit, connections you noticed.

---

## Phase 0 — Setup

2026-05-05 — Built repo structure: `docs/`, `docs/modules/`, `docs/projects/`, `docs/reading/`. Created curriculum map, glossary, and this log.

---

## Phase 1 — Engineering Fundamentals

### CLI-Linux

$PATH essentially is the file structure from which the shell searches.

| is to pipe, and means that the output of the previous command is passed as the input to the next command

&& runs an additional command

touch creates a file

grep or rg search a given directory and all subdirectories

### Git + GitHub

Git stores data as a series of snapshots of your repository over time. When you make a commit, Git stores a commit message with a pointer to the snapshot of the content you staged. This also includes information on who made the commit, when they made the commit, and the parent(s) of the commit: zero parents for an initial commit, one parent for a standard commit, and two parents for a merge of two or more branches.

Branching means you diverge from the main line of development and continue building without interfering directly with the main line, with the option later of taking the branch and integrating it into the main line. Git encourages workflows that branch and merge often.

Git knows what branch you're on using a special pointer called HEAD. The main branch is called the MASTER. Run git branch to see all your current branches.

To create a new branch, use git branch. This creates the new branch, but doesn't switch to it. You can know what branch you're on by running git log --oneline --decorate and seeing what HEAD is pointing to. To switch to a different branch, use git checkout *branch name*. 

To create a new branch and switch to it at the same time, use the -b command: git checkout -b *branch name*. 

When a new commit is made to a branch, the HEAD moves forward with that newly committed branch, while the MASTER stays put.

Use git log *branch name* and git log *branch name* -all to see the previous commit history for a specified branch.

To merge a branch, you will need to check out to the branch you want to merge into:
- git checkout master
- git merge *branch name*

To delete a branch, which is what you should do to the merged branch after merging:
- git branch -d *branch name*

### HTTP + REST APIs

HTTP is a protocol for any exchange or request of data on the internet. Clients and servers communicate by exchanging individual messages. Clients request messages, called requests, and servers respond, called responses.

HTTP is a client-server protocol, where most of the time requests are made by a Web browser, on behalf of the user. To display a Web page, the browser makes a request for the HTML document that represents the page. It parses this document and follows the styling outlined in the document to display the Web page to the user.

A server serves the document, meaning it is a machine with an IP address that hosts the document.

REST stands for REpresentational State Transfer. It is an approach for building web-based APIs (Application Programming Interfaces).

REST is an architectural style. REST is based on principles that promote simplicity, scalability, and statelessness in design. The six guiding principles are:
- Uniform Interface
- Client-Server
- Stateless
- Cacheable
- Layered System
- Code on Demand

*1* A uniform interface relies on four constraints:
(1) Identification of resources - The interface must uniquely identify each resource involved in the interaction between the client and the server

In other words, everything has its own address. 

(2) Manipulation of resources through representations - The resources should have uniform representations in the server response. API consumers should use these representations to modify the resource state in the server

In other words, you get a copy, not the original.

(3) Self-descriptive messages - Each resource representation should carry enough information to describe how to process the message. It should also provide information on the additional actions that the client can perform on the resource

In other words, instructions come with the data.

(4) Hypermedia as the engine of application state - The client should have only the initial URI of the application. The client application should dynamically drive all other resources and interactions with the use of hyperlinks

In other words, instructions are clear step-by-step.

*2* Client-Server
This means that clients and servers are clearly independent from each other but interact through a shared system, called an interface or contract.

*3* Statelessness
Statelessness mandates that each request from the client to the server must contain all of the information necessary to understand and complete the request.

*4* Cacheable
The cacheable constraint requires that a response should implicitly or explicitly label itself as cacheable or non-cacheable.

If the response is cacheable, the client application gets the right to reuse the response data later for equivalent requests and a specified period.

*5* Layered System
The layered system style allows an architecture to be composed of hierarchical layers by constraining component behavior. In a layered system, each component cannot see beyond the immediate layer they are interacting with.

For example if you order something on Amazon, Amazon's website talks to an order system, the order system talks to a payment processor, the payment processor talks to your bank, and the bank talks to its own security system. Each is its own layer that cannot see beyond the layer sending it information.

*6* Code on Demand
REST also allows client functionality to be extended by downloading and executing code in the form of applets or scripts.

The downloaded code simplifies clients by reducing the number of features required to be pre-implemented. Servers can provide part of the features delivered to the client in the form of code, and the client only needs to execute the code.

For example, when you use Google Maps, Google Maps doesn't send the entire map of the world to your device. It just sends wherever you've scrolled to, and if you change the scroll it just sends new data to your device.

### Postman

Postman is a tool that allows you to speak directly to a server, rather than go through a client. If you're a developer who just built a server, you need to check that it's actually working correctly before you build the whole app around it. Postman lets you send a request to the server ("give me user Sarah's profile"), see exactly what the server sends back, and check if it's correct, broken, slow, or returning errors.

### SQL

To retrieve data from a relational database, we use select statements that are also called queries. A query is a message stating what we are looking for, where to find it, and, optionally, how it should be transformed before returning it.

Example:
    SELECT column, another_column, …
    FROM mytable;

If you want to get all columns from the table:
    SELECT *
    FROM mytable;

To filter certain results from being returned, we use WHERE and AND/OR clauses. You can incorporate complex clauses using operators like =, !=, >, <, <=, or >=; BETWEEN...AND...; NOT BETWEEN...AND...; IN...; NOT IN...

There are a few more helpful text operators:
    - = is a case-sensitive exact string comparison
    - != or <> is a case-sensitive inequality comparison
    - LIKE is a case-insensitive exact string comparison
    - NOT LIKE is a case-insensitive exact string inequality comparison
    - \% is used anywhere in a string to match a sequence of zero or more characters. 
        - For example, col_name LIKE \%AT\% is used to find things like CAT, ATTIC, or even BATS
    - - is used anywhere in a string to match a single character (only with LIKE or NOT LIKE)
        - For example, col_name LIKE AN_ will produce AND but not AN

If there are duplicate rows and you want to just remove them all, you can use the DISTINCT clause:
    SELECT DISTINCT column, another_column, …
    FROM mytable
    WHERE condition(s);

You can use the ORDER BY clause to make sure the data is ordered, with ASC or DESC to indicate ascending or descending order:
    SELECT column, another_column, …
    FROM mytable
    WHERE condition(s)
    ORDER BY column ASC/DESC;

You can also use LIMIT to specify the number of rows to return, and OFFSET to indicate where to begin counting:
    SELECT column, another_column, …
    FROM mytable
    WHERE condition(s)
    ORDER BY column ASC/DESC
    LIMIT num_limit OFFSET num_offset;



### Experimentation + A/B Testing

---

## Phase 2 — Shipping Software

### Docker

### Cloud Fundamentals

### CI/CD + Testing

### System Design

### Security

### n8n

### Advanced SQL + Analytics Engineering

---

## Phase 3 — Product Craft + Business/Finance

### PRDs

### Unit Economics

### Financial Statements

### Privacy + Compliance

### Notion

### Figma

### Agile

### Program Management

### Technical Communication

---

## Phase 4 — AI Foundations

### Transformers

### Embeddings

### Predictive ML Evaluation

### LLM Evaluation

### RL + RLHF

### Inference Optimization

### LLM Failure Modes

### MLOps + ML Lifecycle

---

## Phase 5 — AI Product Engineering

### Prompt Engineering

### RAG

### HITL Design

### AI Telemetry

### Red-Teaming

### Model Selection

### LangChain / LangGraph

### Hugging Face

### Keystroke

### OpenClaw

### Intelligent UI

---

## Phase 6 — Landscape + Capstone

### AI Landscape

### Model Economics

### AI Product Strategy

### HCI + Research Areas

### Robotics + Embodied AI

### Social Computing

### Extended Reality

### Mobile + Ubiquitous Computing

### Research Program Management

### AI PM Interviews

### Capstone
