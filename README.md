# README

## To Do
### Biggies
- [ ] Add Group model on top of Users.
  - [ ] joining groups with invitations
    - group attribute: invite code --> checksum
    - send checksum to another user
- [ ] settling debt
  - [ ] create migration to add `reconciled_by_creditor` and `reconciled_by_debtor` boolean to Debt table
- [ ] styling?!

### Little Stuff
- [ ] Devise
  - [ ] lock down actions based on authentication
- [ ] Form validation with errors
- [ ] able to edit and expenses
  - (ugh, how will that affect debts?)
    - everything's associated, so in theory, should be able to update without _too_ much trouble, but not sure yet
