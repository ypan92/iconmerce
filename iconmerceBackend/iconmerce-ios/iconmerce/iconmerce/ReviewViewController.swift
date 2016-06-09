//
//  ReviewViewController.swift
//  iconmerce
//
//  Created by Yang Pan on 6/6/16.
//  Copyright © 2016 iconmerce. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var rating: UILabel!
    
}

class ReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var icon: Icon?
    var user: User?
    var history: Icons?
    var icons: Icons?
    
    var reviewLoader: ReviewLoader?
    
    @IBOutlet weak var reviewPromptLabel: UILabel!
    @IBOutlet weak var reviewField: UITextView!
    @IBOutlet weak var reviewList: UITableView!
    @IBOutlet weak var ratingField: RatingControl!
    
    @IBAction func submitReview(sender: AnyObject) {
        if reviewField.text != "" {
            let rating = ratingField.rating
            let userId = (user?.user_id)!
            let itemId = (icon?.id)!
            let review = reviewField.text
            
            let newReview = Review()
            newReview.userId = Int(userId)
            newReview.itemId = itemId
            newReview.review = review
            newReview.rating = rating
            
            reviewLoader?.newReview = newReview
            reviewLoader?.reviews?.reviews.append(newReview)
            
            reviewField.text = ""
            ratingField.stars = 0
            
            reviewLoader = ReviewLoader()
            reviewLoader?.itemId = (icon?.id)!
            
            performSegueWithIdentifier("testSeg18", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewList.delegate = self
        reviewList.dataSource = self
        
        reviewField.layer.borderWidth = 1
        reviewField.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "testSeg17" {
            let dest = segue.destinationViewController as! IconContainerViewController
            dest.icons = icons
            dest.icon = icon
            dest.user = user
            dest.history = history
        }
        else if segue.identifier == "testSeg18" {
            let dest = segue.destinationViewController as! EmptyPlaceHolderViewController
            dest.icons = icons
            dest.icon = icon
            dest.history = history
            dest.user = user
            //dest.reviewLoader = reviewLoader
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (reviewLoader?.reviews?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewItem", forIndexPath: indexPath) as! ReviewCell
        let review = reviewLoader?.reviews?.reviews[indexPath.row]
        cell.review.text = (review?.review)!
        cell.author.text = (user?.username)!
        cell.rating.text = "Rating: \((review?.rating)!)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        reviewList.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
