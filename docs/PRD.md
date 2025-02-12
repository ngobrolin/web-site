# Ngobrolin WEB - Product Requirements Document
## 1. Product Overview
	Ngobrolin WEB is a video podcast platform focused on delivering engaging content to viewers while providing easy access to episode information, show notes, and communication channels with producers.
## 2. Target Audience
	Primary: Video podcast viewers interested in web-related content and seeking educational content
	Secondary: Potential sponsors and business partners looking to reach the tech audience
	Tertiary: Content requestors and question submitters who want to engage with the show
## 3. Core Features
	### 3.1 Episode Directory
		The episode directory serves as the main content hub where users can browse and discover podcast episodes.
		    
		  **Requirements:**  
			Grid/list view of all podcast episodes
			Episode card elements:
				Thumbnail image
				Episode title
				Publication date
				Duration
				Brief description (2-3 lines)
			Search functionality with filters
				Fulltext search
			Pagination
	### 3.2 Episode Detail Page
	    
	  Individual episode pages that provide the full content and related information.  
	    
	  **Requirements:**  
		Full-width video player at the top
		Persistent mini-player while scrolling
		Show notes section containing:
			Episode timestamp markers with descriptions
			Links to resources mentioned
			Key points and takeaways
			Transcripts (collapsible)
		Social sharing buttons
		Related episodes recommendations (later)
		Comment section (optional)
	### 3.3 About Page
	    
	  **Requirements:**  
		Podcast overview and mission statement
		Host/producer biographies
		Social media links
		Contact information
	### 3.4 Communication Features
		#### Topic Request System
			Structured form fields:
				Topic suggestion
				Reason/context
				Preferred format
				Contact information
			Status tracking
			Auto-response system
		#### Question Submission
			Anonymous submission option
		#### Sponsorship Page
			Sponsorship tiers and packages
			Audience demographics
			Download/view statistics
			Past sponsor showcase
			Contact form
			Media kit download
			Rate card (optional)
## 4. Technical Requirements
	### 4.1 Video Player
		Youtube embed (https://github.com/paulirish/lite-youtube-embed)
	### 4.2 Performance
		Page load time: < 3 seconds
		Mobile-first responsive design
		Progressive loading
		Image optimization
## 5. User Experience Requirements
	### 5.1 Navigation
		Episode search
		Mobile-friendly menu
	### 5.2 Content Organization
		Topic/category tagging
		Popular episodes section
	### 5.3 Accessibility
		WCAG 2.1 AA compliance
		Keyboard navigation
		Screen reader compatibility
		Closed captions
		Alt text for images
		High contrast mode
## 6. Future Considerations
	Member-only content system
	Newsletter integration
	Community forum