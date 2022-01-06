# Consensus

!!! summary
    An area of problems about how to get distributed systems to agree on state or some other piece of information.

**State Machine Replication (SMR)**
: The problem of ensuring that a group of machines maintains agreement on a collective state even under updates (which may only be sent to some of the machines)

**Byzantine Agreement (BA)**
: 
- **Consistency**: All honest parties output the same bit
- **Validity**: If all honest parties input $b$, all honest parties will output $b$
- **Termination**: All honest parties eventually terminate and output some value