//
//  CharacterDetailTableViewController.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 13/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import MXParallaxHeader

class CharacterDetailTableViewController: UITableViewController {
    
    var character: CharacterViewObject!
    var rows: Int = 2
    var sections: [CellType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icn-nav-back-white"), style: .Done, target: self, action: Selector("back:"))
        navigationItem.title = character.name
        
        let backButton = UIButton(type: UIButtonType.Custom)
        backButton.frame = CGRectMake(0, 16, 50, 70)
        backButton.tintColor = UIColor.whiteColor()
        backButton.backgroundColor = UIColor.clearColor()
        backButton.setImage(UIImage(named: "icn-nav-back-white"), forState: .Normal)
        backButton.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let imgHeader = UIImageView()
        imgHeader.loadImageWithUrl(character.thumbnail, placeholder: nil, reloadCache: false)
        imgHeader.contentMode = .ScaleAspectFill
        imgHeader.addSubview(backButton)
        imgHeader.userInteractionEnabled = true
        
        tableView.parallaxHeader.view = imgHeader
        tableView.parallaxHeader.height = (self.view.frame.size.height * 60)/100
        tableView.parallaxHeader.mode = .Fill
        tableView.parallaxHeader.minimumHeight = 0

        tableView.delegate = self
        tableView.dataSource = self
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imgHeader.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let imgBackground = UIImageView()
        imgBackground.loadImageWithUrl(character.thumbnail, placeholder: nil, reloadCache: false)
        imgBackground.contentMode = .ScaleAspectFill
        imgBackground.addSubview(blurEffectView)
        tableView.backgroundView = imgBackground
        
        sections = CharacterPresenter.getDetailCellSections(character)
    }
    
    func back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Set(sections).intersect(sections).count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellType = sections[section]
        return sections.filter({ $0 == cellType}).count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellType = sections[indexPath.section]
        
        switch cellType {
        
        case .NameCellType:
            let cell = tableView.dequeueReusableCellWithIdentifier("SimpleTextTableViewCell", forIndexPath: indexPath) as! SimpleTextTableViewCell
            cell.setupWithText(character.name ?? "")
            return cell
        
        case .DescriptionCellType:
            let cell = tableView.dequeueReusableCellWithIdentifier("SimpleTextTableViewCell", forIndexPath: indexPath) as! SimpleTextTableViewCell
            cell.setupWithText(character.characterDescription ?? "")
            return cell
        
        case .ComicCellType:
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.comics, delegate: self)
            return cell
        
        case .StoryCellType:
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.stories, delegate: self)
            return cell
        
        case .SerieCellType:
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.series, delegate: self)
            return cell
        
        case .EventCellType:
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectionTableViewCell", forIndexPath: indexPath) as! CollectionTableViewCell
            cell.setupWithCollection(character.events, delegate: self)
            return cell
        
        case .LinksCellType:
            let urlVO = character.urls[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("LinksTableViewCell", forIndexPath: indexPath) as! LinksTableViewCell
            cell.setupWithUrlVO(urlVO)
            return cell
        }
        
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cellType = sections[indexPath.section]
        
        switch cellType {
            
        case .NameCellType, .DescriptionCellType :
            return 70
            
        case .ComicCellType, .SerieCellType, .StoryCellType, .EventCellType:
            return 220
            
        default:
            return 50
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = sections[section]
        
        let view = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 27))
        view.backgroundColor = UIColor.clearColor()
        
        let lblSection = UILabel(frame: CGRectMake(8, 5, self.view.bounds.width, 27))
        lblSection.backgroundColor = UIColor.clearColor()
        lblSection.text = sectionType.rawValue
        lblSection.font = UIFont(name: "HelveticaNeue-Bold", size: 11)
        lblSection.textColor = UIColor.redColor()
        
        view.addSubview(lblSection)
        
        return view
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueGallery" {
            let galleryVC = segue.destinationViewController as! GalleryViewController
            galleryVC.collection = sender as! Collection
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension CharacterDetailTableViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension CharacterDetailTableViewController: CollectionTableViewCellDelegate {
    func didSelectItem(collection: Collection) {
        self.performSegueWithIdentifier("segueGallery", sender: character.comics)
    }
}