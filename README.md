# StressLess
Irvin Zhao

## Project Summary
StressLess is a wellness app designed to help users manage stress through data-driven insights. By collecting user inputs and leveraging health data, the app provides personalized stress-relief recommendations using a holistic approach. 

## Value Proposition
Stress is a major issue in the US. According to The American Institute of Stress, in 2024, 43% of adults report anxiety problem, and 45% of college students report experiencing "more than average stress." Hence, the need for stress management remains crucial than ever.

## Primary Purpose
The primary purpose of StressLess is to help individuals, particularly working professionals and university students, manage their stress in a personalized and meaningful way. By offering tailored recommendations, the app empowers them to take better control of their well-being. 

## Target Audience
The app primary targets workers and students who are experiencing high levels of stress due to work demands, academic pressures, or personal responsibilities and are more familiar with modern technology and thus more open to using wellness apps. The app will most likely reach them through advertisement on platforms like LinkedIn, Instagram, and YouTube partnering with wellness advocates.

## Success Criteria
Personally, I would rate the level of success based on data regarding user engagement (e.g. daily check-ins), user satisfaction (e.g. app ratings), and retention rate (how many users return to the app consistently over time), comparing these data to existing and well-acknowledged standards potentially.

## Competitor Analysis
There are a number of wellness apps on the market that are well-polished and have solid user base, which honestly I won't be able to catch up for now. However, StressLess takes a ML-driven stress analysis approach compared to relatively static health management system integrated in other apps, which provides a more tailored experience.

## Monetization Model
A typical model would be separation of tier levels with higher level users have the access to more personalized and richer content, other ways including in-app advertisement or purchase of related products.

## UI/UX Design
Upper section: Reserved for the "go back" function typically seen in iOS apps, potentially integrating some motivational phrases to make it look less empty.  
Middle section: Reserved for progress tracking and potentially other personalized contents (home screen) and the main functionalities after navigation.  
Lower section: Reserved for the navigation hub which includes 3 parts: stress management recommendations, personal profile, and app settings.

## Technical Architecture
ML-based stress management recommendations: require data extraction (working with Apple Healthkit), data collection/storage (3rd party data services are needed), data analysis (tentatively using pre-trained model which might require cloud storage), and presenting different types of recommendation (content API).  
Personalized profile and other contents: data storage services are needed.

## Challenges and Open Questions
Besides working with everything in the technical architecture (which is already a challenge as I have no prior experience, but there are online documentations as well as AI for help), other challenges are as follow:
1. Fine-tuning the model to work better with health data and generate reliable output (as well as the types of output that I can use later), which requires more researching and experimenting.
2. Presenting stress management recommendations: utilizing the model output, what type of recommendations should be presented and in what format,  which requires more research on existing solutions (not necessarily stress management).
