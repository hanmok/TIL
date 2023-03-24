

## Traits
### help communicate and ensure observable sequence properties across *interface boundaries*

 * They can't error out
 * They are observed and subscribed on the main _scheduler_
 * They share resources, which is not surprising since they are both derived from an entity called SharedSequence. Driver automatically gets _share(replay: 1)_,while Signal gets _share()_  
