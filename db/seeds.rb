if Rails.env == 'development'
    PASSWORD = 'password'
    # Create some users
    User.create(first_name: 'Adigun', last_name: 'Efon', email: 'adigun@appstate.co', password: PASSWORD)
    User.create(first_name: 'Adigun', last_name: 'Efon', email: 'adigun2@appstate.co', password: PASSWORD)

    # Create Business
    Business.create(title: 'Oye Enterprise', user_id: User.find_by(email: 'adigun@appstate.co').id)
    Business.create(title: 'Happy state Enterprise', user_id: User.find_by(email: 'adigun@appstate.co').id)
    Business.create(title: 'Lakeside Enterprise', user_id: User.find_by(email: 'adigun2@appstate.co').id)
    Business.create(title: 'Oye Housing', user_id: User.find_by(email: 'adigun2@appstate.co').id)

    # Create Payment Pages
    PaymentPage.create(title: 'Car payment', business_id: Business.find_by(title: 'Oye Enterprise').id)
    PaymentPage.create(title: 'Simple Donation', business_id: Business.find_by(title: 'Happy state Enterprise').id)
    PaymentPage.create(title: 'Car Savings', business_id: Business.find_by(title: 'Lakeside Enterprise').id)
end