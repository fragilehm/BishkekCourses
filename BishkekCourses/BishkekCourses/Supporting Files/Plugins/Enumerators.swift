//
//  Enumerators.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/10/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

enum Devices {
    case IPHONE_4
    case IPHONE_4_7
    case IPHONE_5_5
    case IPHONE_5_8
    case IPAD_12_9
    case IPAD_10_5
    case IPAD_9_7
    case UNKNOWN
}
enum CoursesBySubcategoryDataToShow: String {
    case courses, actions, tutors
}
enum CoursesBySubcategoryCameFrom: String {
    case course, university
}
enum TutorSectionTitle: Int {
    case description = 0
    case timetable
    case contacts
    case branches
}
enum DetailedCourseCellId: String {
    case description = "DescriptionTableViewCell"
    case actions = "CourseActionTableViewCell"
    case contacts = "ContactsTableViewCell"
    case branches = "BranchesTableViewCell"
    case services = "ServicesTableViewCell"
    case departments = "DepartmentTableViewCell"
}
