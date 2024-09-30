# DE Assignment - Building an ETL pipeline 

## Introduction 

## Data pipeline
Now let’s dig into the data. You’ll be creating a data pipeline which transforms and
outputs data that you will then use to answer the last section, “Analysis”. It would
be good idea to have a read through that section too before starting because your
data pipeline will need to be designed to meet its needs.

We’ll be looking to evaluate how reliable, maintainable, and reusable the code is
for your pipeline. When creating a data pipeline, ask yourself questions like: How
well could it handle poor quality data? How hard would it be to change the source
of the data (e.g. from local files to remote files)? How hard would it be to make
changes to the data transformations? How could we monitor its performance?
These questions don’t need to be answered in your implementation, but they are
things to keep in mind when designing your data pipeline.
We would like you to create a data pipeline (or pipelines, up to you!) that:
Ingests the sample chats and categories files that we’ve provided
Performs any validation or cleaning you deem necessary for data quality
assurance
Performs any transformations that you need to facilitate answering the
“Analysis” section below
Outputs the resultant data to a sink (file, database, stream, up to you!) for
consumption downstream.
Tips:
For this exercise, the only consumer of your pipeline’s output data is the code
written for the “Analysis” section below, but that doesn’t mean that your
pipeline won’t have multiple consumers in the future.
Keep in mind that these files are sourced from living database tables - their
contents will be changing in perpetuity as new chat records are created, new
attributes are added to the data, and categories are changed to reflect chat
topic-matter.

## Analysis
Now let’s create a consumer of the data that’s running through your pipeline. We’d
like you to write some code which uses the pipeline’s output data to compute
metrics relating to chat volumes according to the scenario below.
We would like clearly defined answers for each metric. How the metrics are
reported is up to you but keep in mind that we’re more interested in the code that’s
calculating them, not how intricate the reporting is.
Scenario: We would like to change the rostering of customer service agents to be
based on chat volumes. It would allow us to have most of our agents online when
we experience peaks in chats. To aid us in creating this new roster, we would like
to know the following statistics relating to chat volumes:
- 1. The date that saw the lowest number of chats resolved
- 2. The date that saw the highest number of chats resolved
- 3. The median number customer-initiated chats which are resolved per day
- 4. The ten most populous categories for chats created by customers
- 5. The ten categories with the lowest resolution rate <-- assumes resolution rate 1 where resolved dttm is not null
- 6. The ten categories with the fastest resolution time <-- assumes chat-handling time is date diff of resolved dttm anbd created at dttm
- 7. The hourly distribution of chats by time-of-day and day-of-week
Tips:
Agents are always rostered using Melbourne’s timezone.