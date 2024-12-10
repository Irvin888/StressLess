# StressLess (updated)
Irvin Zhao

## Project Summary
StressLess is a wellness app designed to help users manage stress through short-time exercises. By collecting user feedback and analyzing user activities, potentially leveraging health data, the app provides personalized stress-relief experience using a holistic approach. 

## Project Plan
Start with simple features and data storage/collection/analysis, later expand on existing features to incorporate the "personalization" part. Afterwards, focus on the testing part to ensure that the functions work as expected. Finally, maybe review the app publication requirement to learn how far I am from actually publishing it.

## MVP Features (including breakdown of tasks)
1. Progress tracking: displaying relevant info to increase user engagement, need to explore more options for a better user experience.
2. Stress management activities: a variety of short exercises that can help reduce stress level, need to explore more options and implememnt personalization, potentially a better after-exercise feedback collection for better data analysis.

## Mapping Between Features and Value(s)
The stress management activities are intended for providing users (e.g. working professionals and university students) a "quicker way" to calm down hence reduce current stress level to some extent. The activties are short-time because people are more likely to choose other digital content over a boring long time in-app exercise. The progress tracking is there to provide a sense of achievement for better user engagement and retention.

## Success Criteria
Personally, I would rate the level of success based on data regarding user engagement (e.g. daily check-ins), user satisfaction (e.g. app ratings), and retention rate (how many users return to the app consistently over time), comparing these data to existing and well-acknowledged standards potentially.

## Competitor Analysis
There are a number of wellness apps on the market that are well-polished and have solid user base, which honestly I won't be able to catch up for now. However, StressLess takes a data-driven approach that provides a more tailored experience, compared to relatively static health management system integrated in other apps.

## Monetization Model
A typical model would be separation of tier levels with higher level users have the access to more personalized and richer content, other ways including in-app advertisement or purchase of related products.

## UI/UX Design
Upper section: Reserved for the "go back" function typically seen in iOS apps, potentially integrating some motivational phrases to make it look less empty.  
Middle section: Reserved for progress tracking and potentially other personalized contents (home screen) and the main functionalities after navigation.  
Lower section: Reserved for the navigation hub which includes 3 parts: stress management, personal profile, and app settings.

## Technical Architecture
Personalized stress management: require data collection (in-app feedback and Apple Healthkit potentially), data storage (local or 3rd party data services), data analysis (tentatively using avaliable models/algorithms), and presenting different types of recommendation (content API if necessary for certain content).  
Personalized profile and other contents: local or cloud data storage services.

## Challenges and Open Questions
Besides working with everything in the technical architecture (which is already a challenge as I have no prior experience, but there are online documentations as well as AI for help), other challenges are as follow:
1. Working with the model/algorithms to analyze collected data and making personalized recommendations, which requires more researching and experimenting.
