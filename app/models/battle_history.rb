class BattleHistory < ApplicationRecord
  enum result: { challenger: 0, enemy: 1, draw: 2 }
end
