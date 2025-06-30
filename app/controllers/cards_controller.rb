class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]

  # GET /cards
  def index
    @cards = Card.all
  end

  # GET /cards/1
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new(
      shape: Card.shapes.keys.sample,
      color: Card.colors.keys.sample,
      texture: Card.textures.keys.sample,
      number: rand(1..3)
    )
  end

  # GET /cards/1/edit
  def edit
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card, notice: "Card was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      redirect_to @card, notice: "Card was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy!

    redirect_to cards_path, status: :see_other, notice: "Card was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.expect(card: [ :shape, :texture, :color, :number ])
    end
end
