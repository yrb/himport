class Inspection < ApplicationRecord
  belongs_to :hilti_import
  belongs_to :hilti_project

  Marker = Data.define(:origin, :end_point)
  Point = Data.define(:x, :y) do
    def -@
      Point[-self.x, -self.y]
    end

    def -(other)
      Point[self.x - other.x, self.y - other.y]
    end

    def +(other)
      Point[self.x + other.x, self.y + other.y]
    end

    def scale(sX, sY)
      Point[self.x * sX, self.y * sY]
    end

    def flipY
      Point[self.x, 1.0-self.y]
    end
  end

  def floor_plan
    @floor_plan ||= if marker.present?
      hilti_import.floor_plans.find_by reference: self.marker["attachment_id"]
    end
  end

  def marker_location
    @marker_location ||= if floor_plan
      page = floor_plan.page
      b = Point[page.bx, page.by]
      t = Point[page.tx, page.ty]
      s = t - b

      rl = raw_location
      ro = Point[rl[0], rl[1]]
      re = Point[rl[2], rl[3]]

      origin = (ro - b).scale(1.0/s.x, 1.0/s.y).flipY
      end_point = (re - b).scale(1.0/s.x, 1.0/s.y).flipY

      Marker[
        origin:,
        end_point:,
      ]
    end
  end


  def raw_location
    marker["location"].split(",").map(&:to_f)
  end

  def build_from_document(doc)
    self.penetration = doc.to_s
    self.reference = doc.attribute("id").to_s
    self.project_id = doc.attribute("projectId").to_s
    self.category_id = doc.attribute("categoryId").to_s
    self.hilti_project = hilti_import.hilti_projects.find_by(reference: project_id, category_id: category_id)
    self.clarinspect_id = SecureRandom.uuid

    marking_node = doc.xpath('marking').first
    if marking_node
      self.marker = {
        "id": marking_node.attribute("id").to_s,
        "attachment_id": marking_node.attribute("attachmentId").to_s,
        "location": marking_node.text
      }
    end
  end
end
