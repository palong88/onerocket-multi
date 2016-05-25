#seeding plan table
Plan.create(:stripe_id =>p1.id, :name => p1.name, :price => p1.amount, :interval => p1.interval)


p1 = Stripe::Plan.retrieve("Medium Plan")
p1 = Stripe::Plan.retrieve("Large Plan")
p1 = Stripe::Plan.retrieve("plan_startup")