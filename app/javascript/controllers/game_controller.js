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
          console.log("Received data:", data)
          this.handleMessage(data)
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
    console.log("Card clicked", event)
    const activeCount = this.element.querySelectorAll('.clicked').length

    if (activeCount >= 3 && !event.currentTarget.classList.contains('clicked')) {
      console.log("You can only select two cards at a time.")
      return
    }

    const clicked = event.currentTarget.classList.contains('clicked')
    const cardId = event.currentTarget.dataset.cardId

    if (clicked){
      // unselecting card
      this.unhighlightCard(cardId)
      this.subscription.perform('card_unselected', { card_id: cardId, player_id: this.playerIdValue })
    } else {
      this.highlightCard(cardId)
      this.subscription.perform('card_selected', { card_id: cardId, player_id: this.playerIdValue })
    }

  }

  handleMessage(data) {
    if (data.player_id === this.playerIdValue) {
      // current player, so use highlightCard functions
      if (data.action === 'card_selected') {
        this.highlightCard(data.card_id)
      } else if (data.action === 'card_unselected') {
        this.unhighlightCard(data.card_id)
      }
    } else {
      // other palyer, so use highlightPlayerIcon functions
      if (data.action === 'card_selected') {
        this.highlightPlayerIcon(data.card_id, data.player_id)
      } else if (data.action === 'card_unselected') {
        this.unhighlightPlayerIcon(data.card_id, data.player_id)
      }
    }
  }

  highlightPlayerIcon(cardId, playerId) {
    const icon_selector = `[data-card-id="${cardId}"] [data-player-id="${playerId}"]`
    const icon = this.element.querySelector(icon_selector)
    icon.classList.remove('invisible')
  }

  unhighlightPlayerIcon(cardId, playerId) {
    const icon_selector = `[data-card-id="${cardId}"] [data-player-id="${playerId}"]`
    const icon = this.element.querySelector(icon_selector)
    icon.classList.add('invisible')
  }

  highlightCard(cardId) {
    const card = this.element.querySelector(`[data-card-id="${cardId}"]`)
    if (card) {
      card.classList.add('clicked')
    }
  }

  unhighlightCard(cardId) {
    const card = this.element.querySelector(`[data-card-id="${cardId}"]`)
    if (card) {
      card.classList.remove('clicked')
    }
  }
}
