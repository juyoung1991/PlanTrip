//
//  Hotel+CoreDataProperties.swift
//  
//
//  Created by Ju Young Kim on 6/28/17.
//
//

import Foundation
import CoreData


extension Hotel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hotel> {
        return NSFetchRequest<Hotel>(entityName: "Hotel");
    }

    @NSManaged public var business_url: String?
    @NSManaged public var img_url: String?
    @NSManaged public var isClosed: Bool
    @NSManaged public var lat: Double
    @NSManaged public var location: String?
    @NSManaged public var long: Double
    @NSManaged public var name: String?
    @NSManaged public var phone_number: String?
    @NSManaged public var rating: Double
    @NSManaged public var reviewCnt: Int32
    @NSManaged public var day: NSSet?

}

// MARK: Generated accessors for day
extension Hotel {

    @objc(addDayObject:)
    @NSManaged public func addToDay(_ value: Day)

    @objc(removeDayObject:)
    @NSManaged public func removeFromDay(_ value: Day)

    @objc(addDay:)
    @NSManaged public func addToDay(_ values: NSSet)

    @objc(removeDay:)
    @NSManaged public func removeFromDay(_ values: NSSet)

}
