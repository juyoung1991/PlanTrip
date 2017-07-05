//
//  Trip+CoreDataProperties.swift
//  
//
//  Created by Ju Young Kim on 6/28/17.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip");
    }

    @NSManaged public var duration: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var img_url: String?
    @NSManaged public var trip_duration: NSSet?

}

// MARK: Generated accessors for trip_duration
extension Trip {

    @objc(addTrip_durationObject:)
    @NSManaged public func addToTrip_duration(_ value: Day)

    @objc(removeTrip_durationObject:)
    @NSManaged public func removeFromTrip_duration(_ value: Day)

    @objc(addTrip_duration:)
    @NSManaged public func addToTrip_duration(_ values: NSSet)

    @objc(removeTrip_duration:)
    @NSManaged public func removeFromTrip_duration(_ values: NSSet)

}
