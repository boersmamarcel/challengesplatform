Feature: static pages
		In order to have static pages
		as a guest user
		I should be able to visit several pages

		Scenario Outline: visit static page
		When I visit the "<page>" page
		Then I should see the "<page_identifier>" page

		Examples:
		| page | page_identifier|
		| index | index |
		| aboutus | static.aboutus |
		| team  | static.team |
		| createchallenge | static.createchallenge |
		| challengeguidelines | static.challengeguidelines |
		| universities | static.universities |
		| companies | static.companies |
		| termsofservice | static.termsofservice |
		| privacy | static.privacy |
		| press | static.press |



