use crate::data::datastructs::Action;

trait ActionHandler {
    async fn on_action(action: Action);
}



