# pixabay_content_browser

Pixabay Browser for Redbull

## Getting Started

This project was completed based on the use case provided by Redbull.

It offers authenticated users the possibility to browse and view content from Pixabay.

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
