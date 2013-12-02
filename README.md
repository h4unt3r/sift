# sift

sift is a simple utility which is designed to allow you to conduct
operations upon the messages located upon a remote IMAP server.

I found this utility as I was writing a similar imap sorting daemon.
Why rewrite code when its already there?

Many thanks to Steve for this awesome program and saving me countless
hours of tinkering and swearing. I hope to add something of merit to 
the program.

# Sample Usage

To get started you'll need to create a text file containing your
login details and a collection of rules.  Then you may pass that
filename as an argument to sift.

Here is one of the simplest possible rulefiles:

    server:   imap.gmail.com
    username: somebody.says
    password: testing

    folder:inbox status:new mark:read

This marks all new messages in the "inbox" as being read.



# How Sift Works

Each sift rule is considered as part of a chain.  By default when you
select a folder to open **all** messages are selected.

Rules in the chain have two purposes:

1. Refine the list of selected messages.

2. Perform an operation upon ech of the currently selected messages.


For example this will select all messages:

    folder:inbox

This will delete all messages:

    folder:inbox delete

The "delete" operation deletes all currently selected messages.

To refine thing you may reduce the messages selected by filtering on
different fields.  For example:

    folder:inbox subject:foo delete

This will reduce the selection of all messages to all message containing
the word "foo" in their title - then delete them.

# Primitives

As explained there are two types of primitives, or rules, available.

Those that change the selected messages on some criteria, and those that
operate upon the list of selected messages.  These are known as either
"selection" or "operation" rules.


### Selection Rules:

+ folder:foo
Select the specified folder.  To ease use with Googlemail all '#'
characters are converted to spaces.  This allows the following rule
to work as expected:  "folder:[Google#Mail]/Spam delete"

+ body:foo
Reduce the working set to those messages which contain 'foo' in
the body of the message.

+ !body:foo
Reduce the working set to those messages which do not contain 'foo'
in the body of the message.

+ subject:foo
Reduce the working set to those messages which contain 'foo' in the
subject.

+ !subject:foo
Reduce the working set to those messages which do not contain 'foo'
in the subject.

+ from:bar@bar.com
Reduce the working set to those messags which contain 'bar@bar.com'
in the sender address.

+ !from:bar@bar.com
Reduce the working set to those messags which do not contain
'bar@bar.com' in the sender address.

+ to:bar@bar.com
Reduce the working set to those messags which contain 'bar@bar.com'
in the recipient adress.

+ !to:bar@bar.com
Reduce the working set to those messags which do not contain
'bar@bar.com' in the recipient address.

+ status:[new|old]
Select only messags with the given state.  "new" means unread, and
"old" means messages that have been read.


### Operation Rules:

+ copy:bar
Copy all currently selected messages to the folder 'bar'.

+ delete
Delete all currently selected messages.

+ move:bar
Move all currently selected messages into the folder 'bar'.

+ mark:[read|unread]
Mark all selected messages as either read/unread.

+ exec:/usr/local/bin/foo
Run the program "/usr/local/bin/foo" with the body of each selected
message passed as STDIN.  This program is executed once for each
selected message.

+ execonce:/usr/local/bin/foo
Run the program "/usr/local/bin/foo".  This runs the program only
once regardless of the number of selected messages.

+ dump
Provide a brief dump of the selected messages; their sender, recipient,
and subject.


Feedback?
====

The original author no longer maintains this software, please contact
h4unt3r through github, send issues, comments, etc.

Comments welcome to the author <steve [at] steve [dot] org [dot] uk>.

Go check out Steve's website here: <https://github.com/skx/>
Or check out his github here: <http://www.steve.org.uk/>

--h4unt3r
