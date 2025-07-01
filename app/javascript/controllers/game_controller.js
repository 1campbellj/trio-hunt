import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { gameId: String, playerId: Number }
  connect() {
    let consumer = createConsumer();
    this.subscription = consumer.subscriptions.create(
      { channel: "GameChannel", game_id: this.gameIdValue },
      {
        connected: () => {
          console.log(`Connected to game ${this.gameIdValue}`)
        },

        disconnected: () => {
          console.log(`Disconnected from game ${this.gameIdValue}`)
          this.disconnect();
        },

        received: (data) => {
          this.handleCardClick(data)
        }
      }
    )
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }

  clickCard(event) {
    const cardId = event.currentTarget.dataset.cardId
    this.subscription.perform('card_clicked', { card_id: cardId, player_id: this.playerIdValue })
  }

  handleCardClick(data) {
    if (data.action === 'card_clicked') {
      console.log(data);
      console.log(this.playerIdValue);
      if ( data.player_id === this.playerIdValue) {
        this.highlightCard(data.card_id);
      } else {
        this.highlightPlayerIcon(data.card_id, data.player_id);
      }
    }
  }

  highlightPlayerIcon(cardId, playerId) {
    const icon_selector = `[data-card-id="${cardId}"] [data-player-id="${playerId}"]`
    const icon = this.element.querySelector(icon_selector)
    icon.classList.toggle('invisible')
  }

  highlightCard(cardId) {
    const card = this.element.querySelector(`[data-card-id="${cardId}"]`)
    if (card) {
      card.classList.toggle('clicked')
    }
  }
}
