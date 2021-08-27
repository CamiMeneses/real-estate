class Building < ApplicationRecord
  enum type_cd: { house: 'house',
                  department: 'department',
                  land: 'land',
                  commercial_ground: 'commercial_ground' }

  validates :bathrooms, numericality: { greater_than: 0 },
                        if: :bathrooms_positive?
  validates :country, inclusion: { in: COUNTRY_CODES, message: 'Invalid Code' }

  validates_presence_of :name, :type_cd, :street, :external_number, :neighborhood,
                        :city, :country, :rooms, :bathrooms
  validates_presence_of  :internal_number, if: :internal_number_required?
  validates :name, length: { maximum: 128 }
  validates :street, length: { maximum: 128 }
  validates :neighborhood, length: { maximum: 128 }
  validates :city, length: { maximum: 64 }
  validates :external_number, format: {  with: /\A[\w\d\-]+\z/,
                                         message: 'Only alphanumerics and dash (-)' },
                            length: { maximum: 12 }
  validates :internal_number, format: {  with: /\A[\w\d\-\s]+\z/,
                                         message: 'Only alphanumerics, dash (-) and blank spaces' },
                              unless: -> { internal_number.blank? }

  def internal_number_required?
    type_cd == 'department' || type_cd == 'commercial_ground'
  end

  def bathrooms_positive?
    !(type_cd == 'land' || type_cd == 'commercial_ground')
  end
end
