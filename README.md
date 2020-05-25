# To-Do to Done
An app for doing manual daily tracking for whatever in your life you want to track.

* One survey per day
* Surveys always contain all active quesions

If I want to go back to the concept I've built so far I can either checkout this point in history, or just do it again, it wasn't that complicated.

## Data Schema

There are essentially only questions and answers, you just answer questions for a selected day.

### Question
* `body`: the text of the question
* `options`: the possible answer
* `allow_multiple`: whether to allow more than one answer

### Answer
* `question`: what question is being answered
* `options`: which options are selected
* `date`: what day this answer is for
