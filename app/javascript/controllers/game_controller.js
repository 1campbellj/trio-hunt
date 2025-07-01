import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { gameId: String }
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
    this.subscription.perform('card_clicked', { card_id: cardId })
  }

  handleCardClick(data) {
    if (data.action === 'card_clicked') {
      this.highlightCard(data.card_id)
      console.log("Card clicked:", data.card)
    }
  }

  highlightCard(cardId) {
    const card = this.element.querySelector(`[data-card-id="${cardId}"]`)
    if (card) {
      card.classList.add('clicked')
    }
  }
}
