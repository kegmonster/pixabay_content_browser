# pixabay_content_browser

Pixabay Browser for Redbull

## Getting Started

This project was completed based on the use case provided by Redbull.

It offers authenticated users the possibility to browse and view content from Pixabay.

## Features

 - Authentication with a valid username and password
 - Ability to browse a selected list of content categories
 - Each category returns a combined list of the images and videos that match the category
 - Preview images and videos. Video previews provide basic playback
 - Sort the returned content by name or date

## Notes

Authentication is just a sample. There is no backend, so any valid email/password combination
will be a successful login.

## Known issues

Videos names are a bit arbitrary, currently using the collection of tags + video id. 
File extension has been excluded.
Video creation dates are spoofed to the uploading users join date, since it is not clear where 
the actual video date can be found.

API limits: the app currently does not do anything to prevent exceeding api call limits. 
It will fail gracefully if limits are hit, with text to display the reported reason.
Caching has not been implemented as required by the pixabay api.
