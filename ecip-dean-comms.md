# Communicating with 3rd parties

    ECIP: ?
    Author: Dean Pappas, deancpappas@gmail.com
    Status: Draft
    Type: Informational
    Created: 2019-08-06

## Abstract

A process for communicating high priority updates and events to 3rd parties 

## Motivation

One of the biggest issues for coordinated decentralized network upgrades (ie hard fork) is disseminating this information to 3rd parties. As it stands, multiple entities can be contacting 3rd party organizations as “official” representatives, recommending different clients and actions, or even publishing conflicting information that can lead to centralization, network splitting, and other systemic issues caused by this lack of coordination. 

There can also be new processes that come out as a result of this, ie a “safe list” of 3rd party organizations. It is not the purpose of this ECIP to outline these.


## Specification

This process is comprised of 3 parts

1) Representative Selection
2) Message Construction
3) Channels

### Representative Selection

Each Client (geth/multigeth/parity/mantis) should have 1 representative selected to help in the outreach process.  In addition, there should be 2 representatives voted by the Client representatives that are unaffiliated with any of the Organizations.

This selection happens at the “Final Call” of the event.

*For example, at the Final Call of Atlantis, the following representatives are selected:*
1. ETCLabs – Christian
2. ETCCoop – Yaz
3. Parity – Wei
4. IOHK – Kevin
5. Community 1 – Donald
6. Community 2 – Roy


### Message Construction

During Final Call, the author for the message will be assigned to one of the unaffiliated representatives. There will also be a send date agreed upon. The recommended send date is 6 weeks before the event. The draft will be submitted to the representatives no later than 1 week before the send date. 

*Example Message: Initial Communications Setup*

*Hi [Contact Name]*

*I wanted to reach out and setup a technical contact at [Org] for Ethereum Classic. We are gearing up for our Atlantis Hardfork and want to ensure a smooth upgrade with all of our [OrgType] partners.* 

*I'll be sending you the official announcement details within the next couple of weeks, but I wanted to make sure this is your best contact detail and see if there is anyone else on your team that needs to be involved.*

*Looking forward to our continued work together and a successful hard fork!*

### Channels

A channel is defined as a contact name and contact medium, with a very high likelihood of response within 48 hours. 

2 spreadsheets are required: **Contact List** and **Update Status** 

**Contact List**: the official communications channels for all 3rd parties. This must remain semi-private to protect  3rd parties from spam. The entries are updated by the last contact to have a successful response from the Organization. 

*The suggested spreadsheet format* 

`Org | OrgType | Contact Name | Contact Medium | Last Contact | Last Contact By`

*OrgTypes:*
- Exchange
- Miner
- Node
- Wallet
- Publication

*Example entry*

- F2Pool | Miner | Thomas | Wechat - @thomasf2pool | 7/30/2019 | Community 1 – Donald
- Coinbase | Exchange | Bill | Email – bill@coinbase.com | 7/25/2019 | IOHK – Kevin
- Coineal | Exchange | None | None | 7/20/2019 | ETCCoop - Yaz


**Update Status:** a temporary spreadsheet used to coordinate communications for a specific update/event

*The suggested spreadsheet format*

`Org | Rep 1 | Rep 2 | Status` 

*Status Types*

- Complete: acknowledged receipt of the communication
- InProgress1: 1st 2 weeks of attempts, handled by Rep 1
- InProgress2: 2nd 2 weeks of attempts, handled by Rep 2
- Failed: no response after 4 weeks of attempts

*Example entry*

- F2Pool | Community 1 – Donald | ETCLabs – Christian | Complete
- Coinbase | IOHK – Kevin | Community 2 – Roy | InProgress1 



#### Channel Use

After message construction, a “Update Status” spreadsheet is created. Each Representative fills in their name under *Rep1* for every “Org” they are the “Last Contact By”. Rep 2 is assigned by *Rep1* or done on a volunteer basis, whichever occurs first. 

Outreach begins using the last established channel and Status becomes *InProgress1*. During this phase, outreach can extend to different mediums if there is no response within the 1st week.  At the end of the 2nd week, if there is no successful response, status moves to *InProgress2* and *Rep2* begins outreach process, following the same protocol. After 4 weeks of attempts with no response, the status is set to *Failed* and the “Contact List” entry is updated to “No Contact” and “Last Contact” is set to last attempt date and “Contact By” is set to *Rep2*.

Every outreach will include another representative

*Example*

- Email: cc’ing another Rep
- WeChat: group chat
- Ticket: cc’ing and including another Rep’s contact details in the submission

Successful responses are marked as “Success” in the “Update Status” sheet and the “Contact List” is updated.


#### Channel Maintenance

To prevent out of date information in the contact list, the contacts will be refreshed with a generic outreach every month. This outreach will be handled by the last Contact By on the contact list. Adding new contacts would organically occur and there is no need to remove old ones.


### Implementation

The first iteration of this process is the most difficult, as the Contact List is being formed from scratch. 

Representatives are selected once this ECIP is accepted

Once a message has been constructed, the steps would emulate the normal process. Any existing contact list can act as a starting point, with the Representatives filling in information to the best of their abilities.  


