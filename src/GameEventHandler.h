#pragma once
#include "SkseMessagingListener.h"

namespace plugin {
    class GameEventHandler : public SkseMessagingListener {
    private:
        GameEventHandler() = default;
        GameEventHandler(const GameEventHandler&) = delete;
        GameEventHandler& operator=(const GameEventHandler&) = delete;

    public:
        [[nodiscard]] static GameEventHandler& getInstance() {
            static GameEventHandler instance;
            return instance;
        }

        void onLoad() override;
        void onPostLoad() override;
        void onPostPostLoad() override;
        void onInputLoaded() override;
        void onDataLoaded() override;
        void onNewGame() override;
        void onPreLoadGame() override;
        void onPostLoadGame() override;
        void onSaveGame() override;
        void onDeleteGame() override;
    };
}  // namespace plugin
