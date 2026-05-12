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

Often, data is split among many tables in a process called normalization to avoid duplication and allow tables to grow independently. These tables can be merged through JOIN commands.

INNER JOIN merges the current table with another table on the basis of a shared variable, merging the columns from the second table into the first, only where the values of the shared variable line up 1-to-1 (in a basic INNER JOIN).

LEFT JOIN, RIGHT JOIN, and FULL JOIN are used when data from two tables is asymmetric.

A LEFT JOIN merges table A and table B, keeping rows for table A even if they don't have matches from table B. 

A RIGHT JOIN merges table A and table B, keeping rows for table B even if they don't have matches from table A.

A FULL JOIN simply means that rows from both tables are kept, regardless of whether a matching row exists in the other table.

If you plan on merging two tables and want to keep specific columns from both, you list the columns in the SELECT command despite the merge command coming later.

You can use WHERE column IS/IS NOT NULL to test for null values in a given column.

You can use mathematical expressions to transform variables easily:
    SELECT particle_speed / 2.0 AS half_particle_speed
    FROM physics_data
    WHERE ABS(particle_position) * 10.0 > 500;

If doing so, it is best to label a description for an expression using the AS operator:
    SELECT col_expression AS expr_description, …
    FROM mytable;

You can also aggregate data to find important things like averages, maxes, mins, and counts. Furthermore, you can optionally group this by a specific column:
    SELECT *, MAX(col_name) AS max_col_name
    FROM mytable;
    GROUP BY column

#### ORDERING OF COMMANDS IN SELECT QUERIES
SELECT is obviously the first command in a series. FROM and a JOIN command determine where the data is being pulled from, the total working set of data. 

From there, WHERE determines which individual rows are included and which are excluded. The remaining rows selected through WHERE are then grouped using GROUP BY. As a result of the grouping, there will only be as many rows as there are unique values in that column. Implicitly, this means that you should only need to use this when you have aggregate functions in your query.

If the query has a GROUP BY clause, then the constraints in the HAVING clause are then applied to the grouped rows.

From there, if an order is specified by the ORDER BY clause, the rows are then sorted by the specified data in either ascending or descending order. The number of appearing rows can further be constrained by LIMIT and OFFSET. 

    SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
    FROM mytable
        JOIN another_table
        ON mytable.column = another_table.column
        WHERE constraint_expression
        GROUP BY column
        HAVING constraint_expression
        ORDER BY column ASC/DESC
        LIMIT count OFFSET COUNT;

#### SQL SCHEMAS

In SQL, the database schema is what describes the structure of each table, and the datatypes that each column of the table can contain.

To insert new data into an existing table with existing columns:
    INSERT INTO mytable
    VALUES (value_or_expr, another_value_or_expr, …),
        (value_or_expr_2, another_value_or_expr_2, …),
        …;

You can also use UPDATE to replace values in a table.

DELETE can be used to delete specific rows from a table. Leave out WHERE, and all rows will be deleted:
    DELETE FROM mytable
    WHERE condition;

To alter tables by adding or deleting columns, use ALTER TABLE and ADD or DROP:
    ALTER TABLE mytable
    ADD column DataType OptionalTableConstraint 
        DEFAULT default_value;

    ALTER TABLE mytable
    DROP column_to_be_deleted;

You can also use ALTER TABLE to rename the table:
    ALTER TABLE mytable
    RENAME TO new_table_name;

To drop a table and all its data and metadata:
    DROP TABLE IF EXISTS mytable

### Experimentation + A/B Testing

Running experiments incorrectly is a result of peeking, or checking the results before the pre-specified sample size is reached. This is because significance changes depending on the sample size, and if you check before you hit a pre-specified size your significance may differ from the truth.

There are a few solutions on the user's side:
- Don't peek.
- Use a Bayesian experiment design, which allows you to check results at any time.
- Use a sequential design: Sequential experiment design lets you set up checkpoints in advance where you will decide whether or not to continue the experiment, and it gives you the correct significance levels.

There are also solutions on the platform's side:
- Don't compute significance tests until the experiment is done running, meaning don't present ongoing A/B results in a dashboard or anything like that.
- Stop using significance levels to decide whether an experiment should stop or continue.
- Consider excluding the “current estimate” of the treatment effect until the experiment is over.

There are also some really cool ways to reduce the necessary sample size for tests. The first is a process called interleaving, made popular by Netflix, whereas the second is a process called CUPED, which Spotify uses.

Interleaving is meant for ranking problems, typical of search results, recommendation feeds, and content ordering. It involves taking, for example, the world of all possible algorithms, taking two algorithms from that world and switching off showing the best predictions from each algorithm, and then observing the user's behavior based on what is shown. This allows Netflix to figure out which algorithms are best, and from there Netflix can run serious A/B tests based on the reduced number of algorithms.

CUPED is a simple process that takes pre-treatment data and uses that to predict the unit of analysis' outcome. This reduces variance from the outcome, and therefore reduces sample size needed to test the effect of the treatment on the outcome.

---

## Phase 2 — Shipping Software

### Docker
Docker uses containers, which essentially contain everything needed to run an application, such that things don't need to be installed on the host for the application to run, AND everything will run the same regardless of what the host is.

Developers write code locally and share their work with colleagues using Docker containers, which serves as a development environment. From there, they use Docker to push their applications into controlled testing environments where the applications are tested both automatically and manually. Then, when they find bugs, they can re-work the application in the development environment before redeploying the applications back to the testing environment. After iterating until satisfied, getting the fix to customers is as simple as pushing the updated image to the production environment.

The nice thing about Docker is that its so lightweight that it operates with insane speed and allows you to run applications on any type of machine or server.

Docker uses a client-server architecture, which it accesses through a REST API. The Docker client talks to the Docker daemon (dockerd), which builds, runs, and distributes containers. The Docker daemon listens to API requests and manages docker objects like containers, images, networks, and volumes.

The Docker client is typically how people use Docker. Running commands in a command-line like "docker run" sends those commands to the Docker daemon, which executes the commands.

#### Docker Objects

##### Docker Images
A Docker image is a snapshot of instructions for how a container is to be constructed.

##### Docker Containers
A Docker container is a running instance of an image. A container is defined by its image as well as any configuration options you provide to it when you create or start it.

##### Docker Volumes
A Docker volume essentially transfers information across containers that are the same. This is important because typically containers start from the image definition each time the container is booted up, meaning any creating, updating, or deleting of files are lost once the container is exited. Volumes provide the ability to connect specific filepaths of the container back to the host machine. If you mount a directory in the container, changes in that directory are also seen on the host machine. If you mount that same directory across container restarts, those changes are preserved across the containers.

Volume mounts are volumes attached to a directory where data is stored, which allows data to persist. A volume mount is essentially an opaque bucket of data. Docker manages volumes, including the volume's storage location on disk. A volume mount is a great choice when you need somewhere persistent to store your application data.

Bind mounts are similar to volume mounts, but if changes are made to files that reside within containers, with bind mounts the container sees the changes made to the file instantly and doesn't require removing the container, rebuilding it, and re-running it.

#### Docker Multi-Container Apps
A container should do one thing and do it well. For this reason, and for the purpose of scaling, you should use multi-container apps rather than attempt to store everything into a single container.

#### Docker Compose
It feels like a lot to just get a container and an app with a simple purpose set up. I can't imagine configuring a more complicated app. But Docker Compose is meant to make it easier to start up an app. Docker Compose is a tool that helps you define and share multi-container applications. With Compose, you can create a YAML file to define the services and with a single command, you can spin everything up or tear it all down.

### Cloud Fundamentals

### CI/CD + Testing

### System Design

### Security

### n8n

### Advanced SQL + Analytics Engineering

### Product Analytics + Data Instrumentation

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

### Web Development for AI Products

### AI PM Interviews

### Capstone
