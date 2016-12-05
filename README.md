# Expensiv
Welcome to Expensiv, the free, open-source shared expense tracker built with Ruby on Rails! 

Expensiv allows you and a group of friends, roommates, coworkers, international car-thieves, etc. keep track of who owes whom. 

Once you've signed up for an account, you can:
- create a new "group" for expenses (e.g. for your housemates)
- add expenses evenly split among group-members (by default), or with a custom division
- keep track of your outstanding debts and IOUs
- settle up with individual group-members and clean the slate for more expenses down the line

# Sounds great! Can I use it now?

I made this app during my coding bootcamp's Ruby on Rails Project Week (General Assembly DC, WDI12). I still have a lot to do to bring this up to even a "beta" status, but most of the infrastructure is sound, and just about all of the features are working smoothly. If you're still curious, head to [expensiv.herokuapp.com](expensiv.herokuapp.com)

# Key Next Steps:
- [ ] set up user permissions so that all groups are visible only by members (CRITICAL!)
- [ ] keep track of reconcilliations between users (currently debts are simply wiped clean with no record)
- [ ] Overhaul the user-interface (UI was last on my list as the deadline loomed.)
  - [ ] consider something like Bootstrap (seems like a good fit for this project)
  - [ ] re-think the best ways to display debts and IOUs 
- [ ] set up email invitations with MailGun (currently, email invitations are restricted to a sandbox. Once I overhaul the other features and register with a domain, I will be able to easily configure for real emailing)
 
