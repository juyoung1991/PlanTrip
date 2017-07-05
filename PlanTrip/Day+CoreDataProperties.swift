//
//  Day+CoreDataProperties.swift
//  
//
//  Created by Ju Young Kim on 6/28/17.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day");
    }

    @NSManaged public var day_num: String?
    @NSManaged public var location: String?
    @NSManaged public var attraction: NSSet?
    @NSManaged public var hotel: NSSet?
    @NSManaged public var restaurant: NSSet?

}

// MARK: Generated accessors for attraction
extension Day {

    @objc(addAttractionObject:)
    @NSManaged public func addToAttraction(_ value: Attraction)

    @objc(removeAttractionObject:)
    @NSManaged public func removeFromAttraction(_ value: Attraction)

    @objc(addAttraction:)
    @NSManaged public func addToAttraction(_ values: NSSet)

    @objc(removeAttraction:)
    @NSManaged public func removeFromAttraction(_ values: NSSet)

}

// MARK: Generated accessors for hotel
extension Day {

    @objc(addHotelObject:)
    @NSManaged public func addToHotel(_ value: Hotel)

    @objc(removeHotelObject:)
    @NSManaged public func removeFromHotel(_ value: Hotel)

    @objc(addHotel:)
    @NSManaged public func addToHotel(_ values: NSSet)

    @objc(removeHotel:)
    @NSManaged public func removeFromHotel(_ values: NSSet)

}

// MARK: Generated accessors for restaurant
extension Day {

    @objc(addRestaurantObject:)
    @NSManaged public func addToRestaurant(_ value: Restaurant)

    @objc(removeRestaurantObject:)
    @NSManaged public func removeFromRestaurant(_ value: Restaurant)

    @objc(addRestaurant:)
    @NSManaged public func addToRestaurant(_ values: NSSet)

    @objc(removeRestaurant:)
    @NSManaged public func removeFromRestaurant(_ values: NSSet)

}
