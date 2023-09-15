This was a really fun and interesting challenge to do - I learnt a lot. I added the pry gem so as to explore what was happening in the command line, which was very useful in figuring out the logic. I would also like to continue on with the other user stories and will be thinking what to do there.

I spent plenty of the time in the beginning going through the code, researching anything I didn't know and using pry, when necessary, to see exactly what a value was.

In the vein of OOP, it made sense to create a Crate class and follow the skeleton in creating the other commands.Given that the warehouse is managing a crate's placement and its existence, it makes sense to keep logic in there for validating if a crate can fit or (going forward) locating or removing a crate. I followed the user stories as set out in the README and continued with RSpec.

I started with how to initialise a user-created warehouse, the init command, and moved onto viewing a warehouse. I tested throughout and it was excellent in catching any issues. After that, it was creating Crate and storing a crate in said warehouse. There are lots of (edge) cases to consider with something like this.

Other than the time spent on figuring out what the code was doing and getting to grips with RSpec, the store command's and the subsequent logic in the warehouse proved more timely than anticipated, making sure I tried to accommodate for multiple cases and getting coordinates right. As I mention in improvements, I believe there could be some refactoring here.

#### Initial thoughts

The `command_line_interface` class shows each instance of a subclass command (e.g. an instance of `Help` or `Init`), being passed an instance of a new `warehouse` (line 41) and then immediately running `execute`, so this suggested using this `warehouse` within `execute` when necessary.

The empty, provided `init` method in Warehouse threw me initially. With `warehouse` being passed to `Init` from the command line interface, there is already an instance of Warehouse so this suggested creating a warehouse skeleton and then init adds the actual width, height and grid properties.

---

#### Improvements

**Major**

- Creating a class or module to handle specific errors. Inheriting from StandardError and outputting specific error messages depending on the issue? For example, at the moment, if a user is unable to store a crate, it just says that. There is no specific error message confirming why it cannot be stored.
- Related to this, incorrect input in the terminal gives Ruby specific errors - not user errors.
- Improved testing. As this was my first time, no doubt there could be improvements and further functionalities tested. Believe this comes with studying plus practice. Please note the section below for further thoughts.

**Minor**

- Warehouse `crate_can_be_placed?` method looks a little too complex and should be refactored.
- At the moment, the typed command has to be downcase - it does not accept Sentence case or UPPERCASE.
- I know no validations needed to be run on the inputs but, to confirm, it should be checked that in creating a warehouse, neither the height nor width is 0 or negative.

---

#### Thoughts on testing

- I have not written RSpec tests before. It was on my to-do list and it was great learning what I could; I don't believe learning the syntax and writing tests would take _too_ long, but it's about knowing what to test for, and that comes with practice and experience.

- Having `if warehouse.width` in `init.rb` creates a failed test from `command_line_interface_spec` for `it 'can run several commands'`. As `init` is nil, it doesn't expect to find a width property. Adding `width: nil` after `init: nil` passes the test but I do not believe if that's how it should work, editing the test rather than editing the code. Learning about RSpec in detail would assist in me solving this.

- Within `init_spec`, noting the below code:

```ruby
before(:each) do
	init.execute(['5', '4'])
end
```

this runs in the terminal during testing (it outputs text as if I were the user) but I couldn't see how to remove this without some more knowledge about testing.

Also, this test within `init_spec`:
`it 'is expected no new warehouse is created if the user confirms' do`
I'm not sure this accommodates for if a user had tried to create a new warehouse with the same dimensions.

---

As I said, I enjoyed this and look forward to discussing my code and implementing any additional features.
