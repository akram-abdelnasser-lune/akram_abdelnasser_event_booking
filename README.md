- # Assumptions

- User can have only one booking record per event.
- User cannot book an event created by them.
- Events must have a future start time.
- Location in the event is a string
- Total tickets for an event must be greater than or equal to the remaining tickets.
- Users must be authenticated to create, edit, or book events.
- Events can be created, edited, and deleted only by their creators.
- Bookings can be created, updated, and canceled by the users who made them.
- The application uses pagination for listing events and bookings.
- The application uses Bootstrap for styling and layout.
- The application uses Devise for user authentication.
- The application uses CanCanCan for authorization.
- The application uses FactoryBot and RSpec for testing.
- The application uses Faker for generating random data in seeds and tests.
- The application ensures data integrity by using database transactions and locks where necessary.

# Some enhancements that can be done

- **Email Notifications**: Implement email notifications to inform users about booking confirmations, event updates, and cancellations and to confirm regsitrations.
- **Event Search and Filtering**: Add advanced search and filtering options to allow users to find events based on various criteria such as location, date, and category.
- **Event Location**: Allow users to choose a location either by a google map link or country/city.
- **User Profiles**: Enhance user profiles to display information about the user's created events and bookings.
