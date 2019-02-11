### What is an ECLIP?

    ECLIP: 1
    Title: ECLIP Guidelines
    Status: ACTIVE
    Type: Meta
    Author: Your Name <your.email@domain.com>
    Last Updated: 2019-06-02

### Abstract

ECLIP stands for Ethereum Classic Labs Improvement Proposal. Each ECLIP is a design document providing information to the Ethereum Classic community, or describing a new feature for Ethereum Classic or its processes or environment. The ECLIP should provide a concise technical specification of the feature and a rationale for the feature. The ECLIP author is responsible for building consensus within the community and documenting dissenting opinions.

### Motivation
ECLIPs are the primary mechanisms for proposing new features, collecting community input on an issue, and documenting the design decisions that have gone into Ethereum Classic. ECLIPs are maintained as text files in a versioned repository, their revision history is the historical record of the feature proposal.

, and general community who wants to participate in discussion. Drafts can be updated, therefore information generated from discussion can be used to update the pull request or submit a new pull request. When the ECLIP is final, the ECLIP is implemented by the client maintainers or in collaboration with the ECLIP author(s).

### Specification
#### ECLIP Types
There are three kinds of ECLIP:

- A __Standard Track ECLIP__ describes any change that affects most or all Ethereum Classic implementations, such as a change to the the network protocol, a change in block or transaction validity rules, proposed application standards/conventions, or any change or addition that affects the interoperability of applications using Ethereum Classic. Furthermore Standard ECLIPs can be broken down into the following categories. Standards Track ECLIPs consist of three parts, a design document, implementation, and finally if warranted an update to the formal specification.
  - __Core__ - improvements requiring a consensus fork, as well as changes that are not necessarily consensus critical but may be relevant to “core dev” discussions.
  - Networking - includes improvements around devp2p and Light Ethereum Classic Subprotocol, as well as proposed improvements to network protocol specifications of whisper and swarm.
  - __Interface__ - includes improvements around client API/RPC specifications and standards, and also certain language-level standards like method names and contract ABIs. The label “interface” aligns with the interfaces repo and discussion should primarily occur in that repository before an ECLIP is submitted to the ECLIPs repository.
  - __ERC__ - application-level standards and conventions, including contract standards such as token standards (ERC20), name registries (ERC26, ERC137), URI schemes (ERC67), library/package formats (ECLIP82), and wallet formats (ECLIP75, ECLIP85).
- An __Informational ECLIP__ describes an Ethereum Classic design issue, or provides general guidelines or information to the Ethereum Classic community, but does not propose a new feature. Informational ECLIPs do not necessarily represent Ethereum Classic community consensus or a recommendation, so users and implementers are free to ignore Informational ECLIPs or follow their advice.
- A __Meta ECLIP__ describes a process surrounding Ethereum Classic or proposes a change to (or an event in) a process. Process ECLIPs are like Standards Track ECLIPs but apply to areas other than the Ethereum Classic protocol itself. They may propose an implementation, but not to Ethereum Classic's codebase; they often require community consensus; unlike Informational ECLIPs, they are more than recommendations, and users are typically not free to ignore them. Examples include procedures, guidelines, changes to the decision-making process, and changes to the tools or environment used in Ethereum Classic development. Any meta-ECLIP is also considered a Process ECLIP.
- An __Administrative ECLIP__ describes the intent to add a new Github _member_ or _owner_ to _this_ Github organization. 

#### ECLIP Work Flow
```
WIP -> DRAFT -> LAST CALL -> ACCEPTED -> FINAL
       |                     |
       |-> WITHDRAWN         |-> REJECTED
```
Status changes are requested by the ECLIP author and reviewed by the ECLIP editors, then Accepted or Rejected by the core development team, any final when implemented.

#### ECLIP Status

- __WIP__ - an ECLIP that is work in progress. When the author feels their working document is at an intial stage, then the author will notify the ECLIP editors for review. The author and other collaborators may be requested to address changes. When the ECLIP editors determine the document is agreeable, then the ECLIP editors will asign the ECLIP `number`, `type`, `status`, and merge the pull request to master.
  
  WIP may fail to proceed to __Draft__ status if the WIP is not properly formatted, technically unsound, or conflicts with the Ethereum Classic principles of _decentralization_, _state immutability_, and _backward compatibilty_.

- __Draft__ - the intial draft is merged, ECLIP collaborators may update the draft with follow-up pull requests. When the author and participating ECLIP collaborators determine the draft is mature, then they will notify ECLIP editors to proceed to Last Call status with a review period of a minimum of 14 days.

  Last Call status may be denied if the draft is still expecting changes.

- __Last Call__ - an ECLIP in this status is awaiting a minimum of 14 days review or specified period.
  A Last Call will be reverted to Draft if any material or technical complaints arise from the ECLIP collaborators.

  A Last Call with no material or technical complaints during it's review period will be to Accepted.

- __Accepted__ - an Accepted ECLIP is then decided upon the core developer team to inject or implement such changes into a fork. Standard Track ECLIPs must be adopted into at least 3 clients to be final. Example clients: Classic Geth, Multi-Geth, Parity, Mantis, etc...

- __Final__ - The ultimate state of the ECLIP. Final ECLIPs should only be updated to correct errata. Future ECLIPs can revert or signficiantly modify previous ECLIPs. 

Some Informational and Process ECLIPs may also have a status of "Active" if they are never meant to be completed. E.g. ECLIP 1 (this ECLIP).

#### What belongs in a successful ECLIP?
Each ECLIP should have the following parts:

* Preamble - RFC 822 style headers containing metadata about the ECLIP, including the ECLIP number, a short descriptive title (limited to a maximum of 44 characters), the names, and optionally the contact info for each author, etc.

* Abstract - a short (~200 word) description of the technical issue being addressed.

* Specification - The technical specification should describe the syntax and semantics of any new feature. The specification should be detailed enough to allow competing, interoperable implementations for any of the current Ethereum Classic platforms (cpp-ethereum, go-ethereum, ethereumj, ethereumjs).

* Motivation - The motivation is critical for ECLIPs that want to change the Ethereum Classic protocol. It should clearly explain why the existing protocol specification is inadequate to address the problem that the ECLIP solves. ECLIP submissions without sufficient motivation may be rejected outright.

* Rationale - The rationale fleshes out the specification by describing what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work, e.g. how the feature is supported in other languages.

* The rationale should provide evidence of consensus within the community and discuss important objections or concerns raised during discussion.

* Backwards Compatibility - All ECLIPs that introduce backwards incompatibilities must include a section describing these incompatibilities and their severity. The ECLIP must explain how the author proposes to deal with these incompatibilities. ECLIP submissions without a sufficient backwards compatibility treatise may be rejected outright.

* Implementations - The implementations must be completed before any ECLIP is given status "Final", but it need not be completed before the ECLIP is accepted. It is better to finish the specification and rationale first and reach consensus on it before writing code.

* Copyright Waiver - All ECLIPs must be in the public domains. See the bottom of this ECLIP for an example.

#### ECLIP Formats and Templates
ECLIPs should be written in markdown format. Image files should be included in a subdirectory for that ECLIP.

#### ECLIP Header Preamble
Each ECLIP must begin with an RFC 822 style header preamble. The headers must appear in the following order. Headers marked with "*" are optional and are described below. All other headers are required.

      ECLIP: <ECLIP number>
      Title: <ECLIP title>
      Author: <list of authors' real names and optionally, email address>
    * Discussions-To: <email address>
      Status: < WIP, DRAFT, LAST CALL, ACCEPTED or REJECT, FINAL>
      Type: <STANDARDS TRACK, INFORMATIONAL, META>
      Created: <date created on, in ISO 8601 (yyyy-mm-dd) format>
    * Replaces: <ECLIP number>
    * Superseded-By: <ECLIP number>
    * Resolution: <url>

The Author header lists the names, and optionally the email addresses of all the authors/owners of the ECLIP. The format of the Author header value must be

  Random J. User <address@dom.ain>

if the email address is included, and just

  Random J. User

if the address is not given.

If there are multiple authors, each should be on a separate line following RFC 2822 continuation line conventions.

Note: The Resolution header is required for Standards Track ECLIPs only. It contains a URL that should point to an email message or other web resource where the pronouncement about the ECLIP is made.

While an ECLIP is in private discussions (usually during the initial Draft phase), a Discussions-To header will indicate the mailing list or URL where the ECLIP is being discussed. No Discussions-To header is necessary if the ECLIP is being discussed privately with the author.

The Type header specifies the type of ECLIP: Standards Track, Informational, or Meta.

The Created header records the date that the ECLIP was assigned a number. Both headers should be in yyyy-mm-dd format, e.g. 2001-08-14.

ECLIPs may have a Requires header, indicating the ECLIP numbers that this ECLIP depends on.

ECLIPs may also have a Superseded-By header indicating that an ECLIP has been rendered obsolete by a later document; the value is the number of the ECLIP that replaces the current document. The newer ECLIP must have a Replaces header containing the number of the ECLIP that it rendered obsolete.

#### Auxiliary Files
ECLIPs may include auxiliary files such as diagrams. Such files must be named ECLIP-XXXX-Y.ext, where "XXXX" is the ECLIP number, "Y" is a serial number (starting at 1), and "ext" is replaced by the actual file extension (e.g. "png").

#### Transferring ECLIP Ownership
It occasionally becomes necessary to transfer ownership of ECLIPs to a new champion. In general, we'd like to retain the original author as a co-author of the transferred ECLIP, but that's really up to the original author. A good reason to transfer ownership is because the original author no longer has the time or interest in updating it or following through with the ECLIP process, or has fallen off the face of the 'net (i.e. is unreachable or not responding to email). A bad reason to transfer ownership is because you don't agree with the direction of the ECLIP. We try to build consensus around a ECLIP, but if that's not possible, you can always submit a competing ECLIP.

If you are interested in assuming ownership of a ECLIP, send a message asking to take over, addressed to both the original author and the ECLIP editor. If the original author doesn't respond to email in a timely manner, the ECLIP editor will make a unilateral decision.

#### ECLIP Editors
The current ECLIP editors are
  * Members of the ETC Labs Core organization.

#### ECLIP Editor Responsibilities & Workflow
For each new ECLIP that comes in, an editor does the following:

* Read the ECLIP to check if it is ready: sound and complete. The ideas must make technical sense, even if they don't seem likely to be accepted.
* The title should accurately describe the content.
* Edit the ECLIP for language (spelling, grammar, sentence structure, etc.), markup (for reST EWIPs), code style

If the ECLIP isn't ready, the editor will send it back to the author for revision, with specific instructions.

Once the ECLIP is ready for the repository, the ECLIP editor will:

* Assign an ECLIP `number`, `type`, `status` (typically the pull request number)

* Merge initial Draft to master.

* List the ECLIP in [[README.md]]

* Send email back to the ECLIP author with next step.

Many ECLIPs are written and maintained by developers with write access to the Ethereum Classic codebase. The ECLIP editors monitor ECLIP changes, and correct any structure, grammar, spelling, or markup mistakes we see.

The editors don't pass judgment on ECLIPs. Instead their purpose is to administer the ECLIP and play an editorial role.

### Rationale
For Ethereum Classic implementers, ECLIPs are a convenient way to track the progress of their implementation. Ideally each implementation maintainer would list the ECLIPs that they have implemented. This will give end users a convenient way to know the current status of a given implementation or library.

ECLIPs are intended to replace the venerable etherpads which described the initial PoC (Proof of Concept) and strike a balance between ease of accessibility and trackablity.

### History
This document, edited for the specific use of Ethereum Classic, was derived heavily from [https://github.com/bitcoin/bips Bitcoin's BIP-0001] written by Amir Taaki which in turn was derived from [https://www.python.org/dev/peps/ Python's PEP-0001]. In many places text was simply copied and modified. Although the PEP-0001 text was written by Barry Warsaw, Jeremy Hylton, and David Goodger, they are not responsible for its use in the Ethereum Classic Improvement Process, and should not be bothered with technical questions specific to Ethereum, Ethereum Classic, or the ECLIP. Please direct all comments to the ECLIP editors.

Updated: 2019-02-06 by @stevanlohja
> I would like to thank tha contributions from the proceeding ECIP and EIP initiatives.

### Copyright 

Copyright and related waived via [CCO](https://creativecommons.org/publicdomain/zero/1.0/).